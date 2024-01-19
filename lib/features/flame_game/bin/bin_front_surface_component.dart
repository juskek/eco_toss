import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:endless_runner/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BinFrontSurfaceComponent extends RectangleComponent {
  BinFrontSurfaceComponent({super.size}) {
    final pixelCoordinates = EcoTossPostioning.xyzToPixels(
        Vector3(EcoToss3DSpace.xMidMetres, 0, EcoToss3DSpace.zMaxMetres - 0.1));

    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(EcoTossPostioning.width * 0.3, 200);
    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
  }

  @override
  void onLoad() {
    add(RectangleHitbox(isSolid: true));
    super.paint = (Paint()..color = Colors.grey);
  }
}
