import 'dart:math';

import 'package:endless_runner/features/flame_game/bin/bin_dimensions.dart';
import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:endless_runner/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class BallComponent extends CircleComponent
    with
        HasGameReference<EcoTossGame>,
        CollisionCallbacks,
        Notifier,
        DragCallbacks {
  BallComponent({
    required this.radiusStart,
    required this.addScore,
  }) : super(anchor: Anchor.center, priority: 2);

  double radiusStart;

  final void Function({int amount}) addScore;

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

  @override
  void onDragEnd(DragEndEvent event) {
    if (isThrown) {
      return;
    }
    if (event.velocity.y > 0) {
      return;
    }
    if (atan(event.velocity.x.abs() / event.velocity.y.abs()) >
        coneAngleRadians / 2) {
      return;
    }
    isThrown = true;
    xVelocityMps = event.velocity.x / pixelsPerMetre;
    yVelocityMps = event.velocity.y * sin(climbAngleRadians) / pixelsPerMetre;
    zVelocityMps = -event.velocity.y * cos(climbAngleRadians) / pixelsPerMetre;
    print('xVelocityMps: $xVelocityMps');
    print('yVelocityMps: $yVelocityMps');
    print('zVelocityMps: $zVelocityMps');
    super.onDragEnd(event);
  }

  @override
  Future<void> onLoad() {
    add(CircleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (zPositionMetres >= EcoToss3DSpace.zMaxMetres) {
      hasHitBackboard = true;
      zVelocityMps = 0;
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (!isThrown) {
      updatePositionAndRadius();
      return;
    }
    removeIfOutOfBounds();

    removeIfMissed(dt);

    notifyListenersIfPassedBinStart();

    removeIfHitFloor();

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
    super.radius = radiusStart * getScaleFactor(zPositionMetres);
  }

  void removeIfOutOfBounds() {
    if (yPositionMetres.abs() > findGame()!.canvasSize.y / 2) {
      removeFromParent();
    }

    if (xPositionMetres.abs() > findGame()!.canvasSize.x / 2) {
      removeFromParent();
    }
  }

  void removeIfMissed(double dt) {
    if (zPositionMetres >= EcoToss3DSpace.zMaxMetres && !hasHitBackboard) {
      timeSinceMissSeconds += dt;
      super.setColor(Colors.red);
      if (timeSinceMissSeconds >= 1) {
        removeFromParent();
      }
    }
  }

  void removeIfHitFloor() {
    if (yPositionMetres <= yFloorMetres) {
      return;
    }
    print('hit floor, yPosition: $yPositionMetres');
    yVelocityMps = 0;
    if (hasHitBackboard) {
      addScore();
    }
    removeFromParent();
  }

  void applyGravity(double dt) {
    if (yPositionMetres <= yFloorMetres) {
      yVelocityMps = applyGravityToYVelocity(dt, yVelocityMps);
    }
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
