import 'dart:math';

import 'package:eco_toss/features/audio/sounds.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:eco_toss/features/flame_game/utils/load_sprite_animation_from_files.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ThrowableComponent extends SpriteAnimationGroupComponent<ObjectState>
    with
        HasGameReference<BaseEcoTossGame>,
        CollisionCallbacks,
        Notifier,
        DragCallbacks {
  ThrowableComponent({
    required this.radiusStartMetres,
    required this.addScore,
    required this.onMiss,
    required this.binHoleCoordinatesMetres,
    required this.windSpeedMps2,
  }) : super(
            anchor: Anchor.center,
            priority: 2,
            size: Vector2(radiusStartMetres, radiusStartMetres));

  double radiusStartMetres;
  final double windSpeedMps2;

  final void Function({int amount}) addScore;
  final void Function() onMiss;

  double timeSinceMissSeconds = 0;

  double xPositionMetres = EcoToss3DSpace.xMidMetres;
  double yPositionMetres = EcoToss3DSpace.yMidMetres - 1;
  double zPositionMetres = EcoToss3DSpace.zMinMetres;

  double xVelocityMps = 0;
  double yVelocityMps = 0;
  double zVelocityMps = 0;

  bool hasPassedBinStart = false;

  bool isThrown = false;

  bool hasBouncedOffRim = false;

  BinHoleCoordinatesMetres binHoleCoordinatesMetres;

  final List<double> _angles = [];

  @override
  void onDragUpdate(DragUpdateEvent event) {
    double angle = atan2(event.canvasDelta.y, event.canvasDelta.x);
    _angles.add(angle);
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (isThrown) {
      return;
    }
    if (event.velocity.y > 0) {
      return;
    }

    if (_angles.isNotEmpty && _angles.length > 7) {
      int start = (_angles.length * 0.25).round();
      int end = (_angles.length * 0.75).round();

      double sum = 0;
      for (int i = start; i < end; i++) {
        sum += _angles[i];
      }
      double averageAngle = sum / (end - start);

      if ((averageAngle / 2).abs() > EcoTossThrow.noThrowAngleRadians) {
        return;
      }

      if (averageAngle < EcoTossThrow.maxAngleRadians) {
        averageAngle = EcoTossThrow.maxAngleRadians;
      }
      if (averageAngle > EcoTossThrow.minAngleRadians) {
        averageAngle = EcoTossThrow.minAngleRadians;
      }

      isThrown = true;
      game.audioController.playSfx(SfxType.toss);

      current = ObjectState.thrown;
      xVelocityMps = EcoTossThrow.velocityMps * cos(-averageAngle);
      yVelocityMps = EcoTossThrow.velocityMps * sin(-averageAngle);
      zVelocityMps = EcoTossThrow.zVelocityMps;

      _angles.clear();
    }

    super.onDragEnd(event);
  }

  @override
  Future<void> onLoad() async {
    animations = {
      ObjectState.thrown: await loadSpriteAnimationFromFilesToGame(
          game, "throwables/paper_ball/", 48),
      ObjectState.stationary: SpriteAnimation.spriteList(
        [
          await game.loadSprite(
            'throwables/paper_ball/0001.png',
            srcSize: Vector2.all(1080),
            srcPosition: Vector2(0, 0),
          )
        ],
        stepTime: double.infinity,
      ),
    };
    current = ObjectState.stationary;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isThrown) {
      updatePositionAndRadius();
      return;
    }

    bounceIfSlightlyAboveHoleRim();

    checkIfScored(dt);

    removeIfMissed(dt);

    notifyListenersIfPassedBinStart();

    removeIfHitFloor();

    applyWind(dt);

    applyAirResistance();

    applyGravity(dt);

    calculatePosition(dt);

    updatePositionAndRadius();

    super.update(dt);
  }

  void applyWind(double dt) {
    xVelocityMps +=
        windSpeedMps2 * dt * EcoTossThrow.windCoefficientVelocityMultiplier;
  }

  void calculatePosition(double dt) {
    yPositionMetres += getDistanceTravelled(dt, yVelocityMps);
    xPositionMetres += getDistanceTravelled(dt, xVelocityMps);
    zPositionMetres += getDistanceTravelled(dt, zVelocityMps);
  }

  void updatePositionAndRadius() {
    final xyPixels = EcoTossPositioning.xyzMetresToXyPixels(
      Vector3(xPositionMetres, yPositionMetres, zPositionMetres),
    );
    super.position = Vector2(xyPixels.x, xyPixels.y);
    super.size = Vector2(
        radiusStartMetres *
            EcoTossPositioning.xyzPixelsPerMetre *
            getScaleFactor(zPositionMetres),
        radiusStartMetres *
            EcoTossPositioning.xyzPixelsPerMetre *
            getScaleFactor(zPositionMetres));
  }

  bool isBallSlightlyAboveHoleRim() {
    // checks if the ball is within a certain +- threshold of each edge of the hole,
    // and if it is within a certain threshold of the top of the hole

    const yThresholdMetres = 0.15;
    // ignore if ball y position is not near the top of the bin
    if (yPositionMetres < binHoleCoordinatesMetres.frontLeftCornerMetres.y ||
        yPositionMetres >
            binHoleCoordinatesMetres.frontLeftCornerMetres.y +
                yThresholdMetres) {
      return false;
    }
    const thresholdMetres = 0.05;
    // front edge
    if (zPositionMetres >= binHoleCoordinatesMetres.frontLeftCornerMetres.z - thresholdMetres &&
        zPositionMetres <=
            binHoleCoordinatesMetres.frontLeftCornerMetres.z +
                thresholdMetres &&
        xPositionMetres >=
            binHoleCoordinatesMetres.frontLeftCornerMetres.x -
                thresholdMetres &&
        xPositionMetres <=
            binHoleCoordinatesMetres.frontRightCornerMetres.x +
                thresholdMetres) {
      return true;
    }
    // left edge
    if (xPositionMetres >= binHoleCoordinatesMetres.frontLeftCornerMetres.x - thresholdMetres &&
        xPositionMetres <=
            binHoleCoordinatesMetres.frontLeftCornerMetres.x +
                thresholdMetres &&
        zPositionMetres >=
            binHoleCoordinatesMetres.frontLeftCornerMetres.z -
                thresholdMetres &&
        zPositionMetres <=
            binHoleCoordinatesMetres.backLeftCornerMetres.z + thresholdMetres) {
      return true;
    }

    // right edge
    if (xPositionMetres >= binHoleCoordinatesMetres.frontRightCornerMetres.x - thresholdMetres &&
        xPositionMetres <=
            binHoleCoordinatesMetres.frontRightCornerMetres.x +
                thresholdMetres &&
        zPositionMetres >=
            binHoleCoordinatesMetres.frontRightCornerMetres.z -
                thresholdMetres &&
        zPositionMetres <=
            binHoleCoordinatesMetres.backRightCornerMetres.z +
                thresholdMetres) {
      return true;
    }

    // back edge
    if (zPositionMetres >=
            binHoleCoordinatesMetres.backLeftCornerMetres.z - thresholdMetres &&
        zPositionMetres <=
            binHoleCoordinatesMetres.backLeftCornerMetres.z + thresholdMetres &&
        xPositionMetres >=
            binHoleCoordinatesMetres.backLeftCornerMetres.x - thresholdMetres &&
        xPositionMetres <=
            binHoleCoordinatesMetres.backRightCornerMetres.x +
                thresholdMetres) {
      return true;
    }

    return false;
  }

  void bounceIfSlightlyAboveHoleRim() {
    if (hasBouncedOffRim) {
      // prevent multiple bounces due to threshold
      return;
    }
    if (!isBallSlightlyAboveHoleRim()) {
      return;
    }
    yVelocityMps = -yVelocityMps * EcoTossThrow.bounceEnergyYVelocityMultiplier;
    zVelocityMps = zVelocityMps * EcoTossThrow.bounceEnergyZVelocityMultiplier;
    // if on bin side, reverse x velocity
    if (xPositionMetres > binHoleCoordinatesMetres.frontLeftCornerMetres.x &&
        xPositionMetres < binHoleCoordinatesMetres.frontRightCornerMetres.x) {
      xVelocityMps =
          -xVelocityMps * EcoTossThrow.bounceEnergyXVelocityMultiplier;
    }

    // if on outerside, increase x velocity
    if (xPositionMetres < binHoleCoordinatesMetres.frontLeftCornerMetres.x ||
        xPositionMetres > binHoleCoordinatesMetres.frontRightCornerMetres.x) {
      xVelocityMps =
          xVelocityMps / EcoTossThrow.bounceEnergyXVelocityMultiplier;
    }

    hasBouncedOffRim = true;
  }

  bool isBallSlightlyBelowHole() {
    return zPositionMetres >=
            binHoleCoordinatesMetres.frontLeftCornerMetres.z &&
        zPositionMetres <= binHoleCoordinatesMetres.backLeftCornerMetres.z &&
        xPositionMetres >= binHoleCoordinatesMetres.frontLeftCornerMetres.x &&
        xPositionMetres <= binHoleCoordinatesMetres.frontRightCornerMetres.x &&
        yPositionMetres <= binHoleCoordinatesMetres.frontLeftCornerMetres.y;
  }

  void checkIfScored(double dt) {
    if (isBallSlightlyBelowHole()) {
      addScore();
      removeFromParent();
    }
  }

  void removeIfMissed(double dt) {
    if (zPositionMetres >= EcoToss3DSpace.zMaxMetres) {
      timeSinceMissSeconds += dt;
      super.setColor(Colors.red);
      if (timeSinceMissSeconds >= 1) {
        removeFromParent();
        onMiss();
      }
    }
  }

  void removeIfHitFloor() {
    if (yPositionMetres > EcoToss3DSpace.yMinMetres) {
      return;
    }
    yVelocityMps = 0;

    onMiss();
    removeFromParent();
  }

  void applyAirResistance() {
    xVelocityMps -=
        xVelocityMps.abs() * EcoTossThrow.airResistanceVelocityMultiplier;
    yVelocityMps -=
        yVelocityMps.abs() * EcoTossThrow.airResistanceVelocityMultiplier;
    zVelocityMps -=
        zVelocityMps.abs() * EcoTossThrow.airResistanceVelocityMultiplier;

    if (xVelocityMps.abs() < 0.01) xVelocityMps = 0;
    if (yVelocityMps.abs() < 0.01) yVelocityMps = 0;
    if (zVelocityMps.abs() < 0.01) zVelocityMps = 0;
  }

  void applyGravity(double dt) {
    yVelocityMps = applyGravityToYVelocity(dt, yVelocityMps);
  }

  void notifyListenersIfPassedBinStart() {
    if (zPositionMetres >=
            EcoToss3DSpace.zMaxMetres - BinDimensions.depthMetres &&
        !hasPassedBinStart) {
      hasPassedBinStart = true;
      notifyListeners();
    }
  }
}

enum ObjectState {
  thrown,
  stationary,
}
