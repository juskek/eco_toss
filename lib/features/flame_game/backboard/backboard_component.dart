import 'package:endless_runner/features/flame_game/backboard/backboard_dimensions.dart';
import 'package:endless_runner/features/flame_game/bin/bin_dimensions.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:endless_runner/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackboardComponent extends RectangleComponent with CollisionCallbacks {
  BackboardComponent({super.size}) {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
        EcoToss3DSpace.xMidMetres,
        BinDimensions.heightMetres,
        EcoToss3DSpace.zMaxMetres));

    final height = EcoTossPositioning.ySizeMetresToPixels(
        BackboardDimensions.heightMetres);
    final width =
        EcoTossPositioning.xSizeMetresToPixels(BackboardDimensions.widthMetres);
    final sizeScale = getScaleFactor(EcoToss3DSpace.zMaxMetres);
    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(width * sizeScale, height * sizeScale);
    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
    super.paint = (Paint()..color = Colors.blue);
  }

  @override
  void onLoad() {
    add(RectangleHitbox(isSolid: true));
  }
}
