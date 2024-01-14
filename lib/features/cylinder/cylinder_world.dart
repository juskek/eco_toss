import 'dart:async';
import 'dart:math';

import 'package:endless_runner/features/cylinder/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class CylinderWorld extends World {
  static const double startPositionX = -150;
  static const double positionIncrementX = 35;
  static const double rotationalIncrement = pi / 4;
  FutureOr<void> addRotationsAroundY() async {
    const int numberOfComponents = 9;

    const double positionY = -200;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (rotationalIncrement));

      add(PositionComponent(
        position: Vector2(positionX, positionY),
        children: [
          CylinderComponent(
            rotationX: 0,
            rotationY: rotation,
            rotationZ: 0,
          ),
        ],
      ));
    }
  }

  FutureOr<void> addRotationsAroundX() async {
    const int numberOfComponents = 9;
    const double positionY = -300;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (rotationalIncrement));

      add(PositionComponent(
        position: Vector2(positionX, positionY),
        children: [
          CylinderComponent(
            rotationX: rotation,
            rotationY: 0,
            rotationZ: 0,
          ),
        ],
      ));
    }
  }

  FutureOr<void> addRotationsAroundZ() async {
    const int numberOfComponents = 9;
    const double positionY = -100;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (rotationalIncrement));

      add(PositionComponent(
        position: Vector2(positionX, positionY),
        children: [
          CylinderComponent(
            rotationX: 0,
            rotationY: 0,
            rotationZ: rotation,
          ),
        ],
      ));
    }
  }

  FutureOr<void> addRotationsAroundXWithSomeY() async {
    const int numberOfComponents = 9;
    const double positionY = 0;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (rotationalIncrement));

      add(PositionComponent(
        position: Vector2(positionX, positionY),
        children: [
          CylinderComponent(
            rotationX: rotation,
            rotationY: pi / 4,
            rotationZ: 0,
          ),
        ],
      ));
    }
  }

  @override
  Future<void> onLoad() async {
    addRotationsAroundX();
    addRotationsAroundY();
    addRotationsAroundZ();
    addRotationsAroundXWithSomeY();
  }
}
