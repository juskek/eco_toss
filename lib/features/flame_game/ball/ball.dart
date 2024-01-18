import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BallComponent extends CircleComponent
    with HasGameReference<EcoTossGame>, CollisionCallbacks, Notifier {
  BallComponent({
    required this.radiusStart,
    required this.xVelocity,
    required this.yVelocity,
    required this.zVelocity,
  }) : super(anchor: Anchor.center);

  double radiusStart;

  @Deprecated('not in use since we are using getDistance()')
  double timeElapsed = 0;

  double timeSinceMissSeconds = 0;

  double xPosition = 0;
  double yPosition = 100;
  double zPosition = 0;

  double xVelocity;
  double yVelocity;
  double zVelocity;

  bool hasHitBackboard = false;

  @override
  Future<void> onLoad() {
    add(CircleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (zPosition >= zEndMetres) {
      hasHitBackboard = true;
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (zPosition >= zEndMetres && !hasHitBackboard) {
      timeSinceMissSeconds += dt;
      super.setColor(Colors.red);
      if (timeSinceMissSeconds >= 1) {
        removeFromParent();
      }
    }
    if (hasHitBackboard) {
      zVelocity = 0;
    }
    if (yPosition <= yFloorPixels) {
      yVelocity = applyGravityToYVelocity(dt, yVelocity);
      yPosition += getDistanceTravelled(dt, yVelocity);
    } else {
      yVelocity = 0;
      removeFromParent();
    }

    xPosition += getDistanceTravelled(dt, xVelocity);
    zPosition += getDistanceTravelled(dt, zVelocity);

    super.position = Vector2(xPosition, yPosition);
    double scaleFactor = getScaleFactor(zPosition);
    super.radius = radiusStart * scaleFactor;
    super.update(dt);
  }
}
