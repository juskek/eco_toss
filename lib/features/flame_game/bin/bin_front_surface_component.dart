import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'bin_dimensions.dart';

class BinFrontSurfaceComponent extends RectangleComponent {
  final BinType binType;
  late Vector2 topEdgeXyPixels;

  BinFrontSurfaceComponent({required this.binType, super.size}) {
    final pixelCoordinates = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
        EcoToss3DSpace.xMidMetres, 0, BinDimensions.frontSurfaceZMetres));
    final height =
        EcoTossPositioning.ySizeMetresToPixels(BinDimensions.heightMetres);
    final width =
        EcoTossPositioning.xSizeMetresToPixels(BinDimensions.widthMetres);
    final sizeScale = getScaleFactor(BinDimensions.frontSurfaceZMetres);

    topEdgeXyPixels = Vector2(pixelCoordinates.x, pixelCoordinates.y - height);

    super.position = Vector2(pixelCoordinates.x, pixelCoordinates.y);
    super.size = Vector2(width * sizeScale, height * sizeScale);

    super.anchor = Anchor.bottomCenter;
    super.priority = 1;
  }

  @override
  void onLoad() async {
    late String imagePath;
    switch (binType) {
      case BinType.general:
        imagePath = 'bins/BlackBin_Front.png';
        break;
      case BinType.plastic:
        imagePath = 'bins/RedBin_Front.png';
        break;
      case BinType.glass:
        imagePath = 'bins/GreenBin_Front.png';
        break;
      case BinType.paper:
        imagePath = 'bins/BlueBin_Front.png';
        break;
      case BinType.metal:
        imagePath = 'bins/GreyBin_Front.png';
        break;
      default:
        throw Exception('Invalid bin type');
    }

    final sprite = await Sprite.load(imagePath);
    add(SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      position: Vector2(size.x / 2,
          size.y / 2 + BinDimensions.binFrontSurfaceImageYCorrectionPixels),
      scale: Vector2(BinDimensions.binFrontSurfaceImageScale,
          BinDimensions.binFrontSurfaceImageScale),
    ));

    super.paint = (Paint()
      ..color = Colors.blue.withOpacity(showGameTuningUtils ? 0.2 : 0));
  }
}
