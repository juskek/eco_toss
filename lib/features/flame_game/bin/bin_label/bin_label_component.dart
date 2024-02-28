import 'dart:ui' as ui show Image, instantiateImageCodec;

import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_custom_painter.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class BinLabelComponent extends CustomPainterComponent {
  BinLabelComponent();

  @override
  Future<void> onLoad() async {
    size = Vector2.all(50);
    priority = 2;

    final ByteData data =
        await rootBundle.load('assets/images/labels/glass.png');
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 300,
      targetWidth: 300,
    );
    var frame = await codec.getNextFrame();
    image = frame.image;

    // final imageFile = File('assets/images/labels/glass.png');
    // image = await decodeImageFromList(await imageFile.readAsBytes());
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
