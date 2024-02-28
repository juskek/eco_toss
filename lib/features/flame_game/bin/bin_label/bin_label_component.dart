import 'dart:ui' as ui show Image, instantiateImageCodec;

import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_custom_painter.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class BinLabelComponent extends CustomPainterComponent {
  BinLabelComponent({
    required this.binType,
    required this.midpointXMetres,
    required this.frontSurfaceTopEdgeXyPixels,
  });

  final BinType binType;
  final double midpointXMetres;
  final Vector2 frontSurfaceTopEdgeXyPixels;

  @override
  Future<void> onLoad() async {
    const height = 580;
    const width = 425;
    size = Vector2(width.toDouble(), height.toDouble());
    anchor = Anchor.center;
    position = Vector2(width.toDouble() / 2, height.toDouble() / 2);
    priority = 2;

    late String imagePath;
    switch (binType) {
      case BinType.general:
        imagePath = 'assets/images/labels/general.png';
        break;
      case BinType.plastic:
        imagePath = 'assets/images/labels/plastic.png';
        break;
      case BinType.glass:
        imagePath = 'assets/images/labels/glass.png';
        break;
      case BinType.paper:
        imagePath = 'assets/images/labels/paper.png';
        break;
      case BinType.metal:
        imagePath = 'assets/images/labels/metal.png';
        break;
      default:
        throw Exception('Invalid bin type');
    }

    final ByteData data = await rootBundle.load(imagePath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: height,
      targetWidth: width,
    );
    var frame = await codec.getNextFrame();
    image = frame.image;
  }

  late ui.Image image;

  @override
  void update(double dt) {
    painter = BinLabelCustomPainter(
      image: image,
      positionPixels: frontSurfaceTopEdgeXyPixels,
    );

    super.update(dt);
  }
}
