import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'bin_dimensions.dart';

class BinFrontSurfaceComponent extends RectangleComponent {
  BinFrontSurfaceComponent({super.size}) {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
        EcoToss3DSpace.xMidMetres, 0, BinDimensions.frontSurfaceZMetres));
    final height =
        EcoTossPositioning.ySizeMetresToPixels(BinDimensions.heightMetres);
    final width =
        EcoTossPositioning.xSizeMetresToPixels(BinDimensions.widthMetres);
    final sizeScale = getScaleFactor(BinDimensions.frontSurfaceZMetres);

    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(width * sizeScale, height * sizeScale);

    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
  }

  @override
  void onLoad() async {
    add(RectangleHitbox(isSolid: true));
    final sprite = await Sprite.load('bins/BlueBin_Front.png');
    add(SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      position: Vector2(size.x / 2,
          size.y / 2 + BinDimensions.binFrontSurfaceImageYCorrectionPixels),
      scale: Vector2(BinDimensions.binFrontSurfaceImageScale,
          BinDimensions.binFrontSurfaceImageScale),
    ));

    super.paint = (Paint()..color = Colors.blue.withOpacity(0.2));
  }
}
