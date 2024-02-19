import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'bin_dimensions.dart';

class BinBackSurfaceComponent extends RectangleComponent {
  BinBackSurfaceComponent({super.size}) {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
      EcoToss3DSpace.xMidMetres,
      0,
      BinDimensions.backSurfaceZMetres,
    ));
    final height =
        EcoTossPositioning.ySizeMetresToPixels(BinDimensions.heightMetres);
    final width =
        EcoTossPositioning.xSizeMetresToPixels(BinDimensions.widthMetres);
    final sizeScale = getScaleFactor(EcoToss3DSpace.zMaxMetres);

    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(width * sizeScale, height * sizeScale);

    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
  }

  @override
  void onLoad() async {
    add(RectangleHitbox(isSolid: true));
    // sprite = await Sprite.load('bins/blue_bin.png');

    super.paint = (Paint()..color = Colors.grey);
  }
}