import 'dart:ui' as ui show Image, instantiateImageCodec;

import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_custom_painter.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class BinLabelComponent extends CustomPainterComponent {
  BinLabelComponent({
    required this.midpointXMetres,
  });

  final double midpointXMetres;

  @override
  Future<void> onLoad() async {
    const height = 580;
    const width = 425;
    size = Vector2(width.toDouble(), height.toDouble());
    anchor = Anchor.center;
    position = Vector2(width.toDouble() / 2, 0);
    priority = 2;

    final ByteData data =
        await rootBundle.load('assets/images/labels/glass.png');
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
    );

    super.update(dt);
  }
}
