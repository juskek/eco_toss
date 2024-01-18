import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BinComponent extends RectangleComponent with CollisionCallbacks {
  BinComponent({super.size})
      : super(
          anchor: Anchor.bottomCenter,
          position: Vector2(0, yFloorPixels),
          priority: 1,
        );

  @override
  void onLoad() {
    add(RectangleHitbox(isSolid: true));
    super.paint = (Paint()..color = Colors.grey);
  }
}
