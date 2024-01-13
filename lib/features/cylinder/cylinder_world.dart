import 'dart:async';
import 'dart:math';

import 'package:endless_runner/features/cylinder/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class CylinderWorld extends World {
  FutureOr<void> addRotationsAroundY() async {
    add(PositionComponent(position: Vector2(-100, -300), children: [
      CylinderComponent(rotationX: 0, rotationY: -pi, rotationZ: 0)
    ]));
    add(PositionComponent(position: Vector2(-50, -300), children: [
      CylinderComponent(rotationX: 0, rotationY: -pi / 2, rotationZ: 0)
    ]));
    add(PositionComponent(position: Vector2(-0, -300), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
    add(PositionComponent(position: Vector2(50, -300), children: [
      CylinderComponent(rotationX: 0, rotationY: pi / 2, rotationZ: 0)
    ]));
    add(PositionComponent(position: Vector2(100, -300), children: [
      CylinderComponent(rotationX: 0, rotationY: pi, rotationZ: 0)
    ]));
  }

  @override
  Future<void> onLoad() async {
    addRotationsAroundY();
  }
}
