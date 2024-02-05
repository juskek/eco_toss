import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FloorFarEdge extends RectangleComponent {
  FloorFarEdge() {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(
        Vector3(EcoToss3DSpace.xMidMetres, 0, EcoToss3DSpace.zMaxMetres));

    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(EcoTossPositioning.width, 2);
    super.anchor = Anchor.center;
    super.setColor(Colors.red);
  }
}
