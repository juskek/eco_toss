import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:endless_runner/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'bin_dimensions.dart';

class BinFrontSurfaceComponent extends RectangleComponent {
  BinFrontSurfaceComponent({super.size}) {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(
        Vector3(EcoToss3DSpace.xMidMetres, 0, EcoToss3DSpace.zMaxMetres - 0.1));
    final height =
        EcoTossPositioning.ySizeMetresToPixels(BinDimensions.heightMetres);
    final width =
        EcoTossPositioning.xSizeMetresToPixels(BinDimensions.widthMetres);
    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(width, height);
    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
  }

  @override
  void onLoad() {
    add(RectangleHitbox(isSolid: true));
    super.paint = (Paint()..color = Colors.grey);
  }
}
