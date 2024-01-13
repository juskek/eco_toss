import 'dart:math';

import 'package:endless_runner/features/cylinder/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class CylinderWorld extends World {
  @override
  Future<void> onLoad() async {
    await add(PositionComponent(position: Vector2(0, 0), children: [
      CylinderComponent(rotationX: pi / 4, rotationY: pi / 4, rotationZ: pi / 4)
    ]));
    await add(PositionComponent(position: Vector2(100, 100), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
    await add(PositionComponent(position: Vector2(200, 200), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
  }
}
