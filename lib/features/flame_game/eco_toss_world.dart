import 'dart:math';

import 'package:endless_runner/features/flame_game/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class EcoTossWorld extends World {
  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      position: Vector2(150, 50),
      size: Vector2.all(30),
      angle: pi / 4,
      anchor: Anchor.center,
    ));

    add(PositionComponent(
        position: Vector2(0, 0), children: [CylinderComponent()]));
  }
}
