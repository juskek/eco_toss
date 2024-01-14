import 'dart:async';
import 'dart:math';

import 'package:endless_runner/features/cylinder/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class CylinderWorld extends World {
  FutureOr<void> addRotationsAroundY() async {
    const int numberOfComponents = 5;
    const double startPositionX = -100;
    const double positionIncrementX = 50;
    const double positionY = -200;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (pi / 2));

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
    const int numberOfComponents = 5;
    const double startPositionX = -100;
    const double positionIncrementX = 50;
    const double positionY = -300;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (pi / 2));

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
    const int numberOfComponents = 5;
    const double startPositionX = -100;
    const double positionIncrementX = 50;
    const double positionY = -100;

    for (int i = 0; i < numberOfComponents; i++) {
      double positionX = startPositionX + (i * positionIncrementX);
      double rotation = -pi + (i * (pi / 2));

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

  @override
  Future<void> onLoad() async {
    addRotationsAroundX();
    addRotationsAroundY();
    addRotationsAroundZ();
  }
}
