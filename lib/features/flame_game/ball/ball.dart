import 'dart:math';

import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
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

  double xPosition = 0;
  double yPosition = 100;
  double zPosition = 0;

  double xVelocity = 0;
  double yVelocity = 0;
  double zVelocity = 0;

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
    xVelocity = throwingVelocityScale * event.velocity.x;
    yVelocity =
        throwingVelocityScale * event.velocity.y * sin(climbAngleRadians);
    zVelocity =
        throwingVelocityScale * -event.velocity.y * cos(climbAngleRadians);
    super.onDragEnd(event);
  }

  @override
  Future<void> onLoad() {
    add(CircleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (zPosition >= zEndMetres) {
      hasHitBackboard = true;
      zVelocity = 0;
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
    yPosition += getDistanceTravelled(dt, yVelocity);
    xPosition += getDistanceTravelled(dt, xVelocity);
    zPosition += getDistanceTravelled(dt, zVelocity);
  }

  void updatePositionAndRadius() {
    super.position = Vector2(xPosition, yPosition);
    super.radius = radiusStart * getScaleFactor(zPosition);
  }

  void removeIfOutOfBounds() {
    if (yPosition.abs() > findGame()!.canvasSize.y / 2) {
      removeFromParent();
    }

    if (xPosition.abs() > findGame()!.canvasSize.x / 2) {
      removeFromParent();
    }
  }

  void removeIfMissed(double dt) {
    if (zPosition >= zEndMetres && !hasHitBackboard) {
      timeSinceMissSeconds += dt;
      super.setColor(Colors.red);
      if (timeSinceMissSeconds >= 1) {
        removeFromParent();
      }
    }
  }

  void removeIfHitFloor() {
    if (yPosition <= yFloorPixels) {
      return;
    }
    yVelocity = 0;
    if (hasHitBackboard) {
      addScore();
    }
    removeFromParent();
  }

  void applyGravity(double dt) {
    if (yPosition <= yFloorPixels) {
      yVelocity = applyGravityToYVelocity(dt, yVelocity);
    }
  }

  void notifyListenersIfPassedBinStart() {
    if (zPosition >= zBinStartMetres && !hasPassedBinStart) {
      hasPassedBinStart = true;
      notifyListeners();
    }
  }
}
