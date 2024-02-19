import 'dart:math';

import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class BallComponent extends SpriteAnimationGroupComponent<ObjectState>
    with
        HasGameReference<BaseEcoTossGame>,
        CollisionCallbacks,
        Notifier,
        DragCallbacks {
  BallComponent({
    required this.radiusStartMetres,
    required this.addScore,
    required this.onMiss,
  }) : super(
            anchor: Anchor.center,
            priority: 2,
            size: Vector2(radiusStartMetres, radiusStartMetres));

  double radiusStartMetres;

  final void Function({int amount}) addScore;
  final void Function() onMiss;

  double timeSinceMissSeconds = 0;

  double xPositionMetres = EcoToss3DSpace.xMidMetres;
  double yPositionMetres = EcoToss3DSpace.yMidMetres - 1;
  double zPositionMetres = EcoToss3DSpace.zMinMetres;

  double xVelocityMps = 0;
  double yVelocityMps = 0;
  double zVelocityMps = 0;

  bool hasHitBackboard = false;
  bool hasPassedBinStart = false;

  bool isThrown = false;

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
    if (atan(event.velocity.x.abs() / event.velocity.y.abs()) >
        EcoTossThrow.coneAngleRadians / 2) {
      return;
    }

    if (_angles.isNotEmpty) {
      isThrown = true;
      current = ObjectState.thrown;

      double averageAngle = _angles.reduce((a, b) => a + b) / _angles.length;
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
      ObjectState.thrown: await game.loadSpriteAnimation(
        'throwables/paper_ball.png',
        SpriteAnimationData.sequenced(
          amount: 24,
          textureSize: Vector2.all(128),
          texturePosition: Vector2(0, 0),
          stepTime: 0.01,
        ),
      ),
      ObjectState.stationary: SpriteAnimation.spriteList(
        [
          await game.loadSprite(
            'throwables/paper_ball.png',
            srcSize: Vector2.all(128),
            srcPosition: Vector2(0, 0),
          )
        ],
        stepTime: double.infinity,
      ),
    };
    current = ObjectState.stationary;
    add(CircleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isThrown) {
      updatePositionAndRadius();
      return;
    }
    bounceIfHitWalls();

    removeIfMissed(dt);

    notifyListenersIfPassedBinStart();

    removeIfHitFloor();

    applyAirResistance();

    applyGravity(dt);

    calculatePosition(dt);

    updatePositionAndRadius();

    super.update(dt);
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

  void removeIfMissed(double dt) {
    if (zPositionMetres >= EcoToss3DSpace.zMaxMetres && !hasHitBackboard) {
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
    if (hasHitBackboard) {
      addScore();
    } else {
      onMiss();
    }
    removeFromParent();
  }

  void bounceIfHitWalls() {
    if (xPositionMetres > EcoToss3DSpace.xMaxMetres) {
      xVelocityMps = -xVelocityMps * 0.9;
    }
    if (xPositionMetres < EcoToss3DSpace.xMinMetres) {
      xVelocityMps = -xVelocityMps * 0.9;
    }
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
