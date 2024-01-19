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
    isThrown = true;
    xVelocity = event.velocity[0];
    yVelocity = event.velocity[1];
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
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    double scaleFactor = getScaleFactor(zPosition);

    if (!isThrown) {
      super.position = Vector2(xPosition, yPosition);
      super.radius = radiusStart * scaleFactor;
      super.update(dt);
      return;
    }

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
    if (zPosition >= zBinStartMetres && !hasPassedBinStart) {
      hasPassedBinStart = true;
      notifyListeners();
    }
    if (yPosition <= yFloorPixels) {
      yVelocity = applyGravityToYVelocity(dt, yVelocity);
      yPosition += getDistanceTravelled(dt, yVelocity);
    } else {
      yVelocity = 0;
      if (hasHitBackboard) {
        addScore();
      }
      removeFromParent();
    }

    xPosition += getDistanceTravelled(dt, xVelocity);
    zPosition += getDistanceTravelled(dt, zVelocity);

    super.position = Vector2(xPosition, yPosition);
    super.radius = radiusStart * scaleFactor;
    super.update(dt);
  }
}
