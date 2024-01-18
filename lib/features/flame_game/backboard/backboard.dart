import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackboardComponent extends RectangleComponent with CollisionCallbacks {
  BackboardComponent({super.size})
      : super(anchor: Anchor.center, position: Vector2(0, 170));

  @override
  void onLoad() {
    add(RectangleHitbox(isSolid: true));
    super.paint = (Paint()..color = Colors.red);
  }
}
