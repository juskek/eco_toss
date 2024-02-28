import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';

class BinLabelCustomPainter extends CustomPainter {
  final bool _showAnchor = true;

  final ui.Image image;
  const BinLabelCustomPainter({required this.image});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const scale = 0.3;
    // const scale = 0.15;
    canvas.scale(scale, scale);
    canvas.drawImage(image, Offset(-size.width / 2, -size.height / 2), Paint());

    if (_showAnchor) {
      const anchorSize = 15.0;
      final path = Path()
        ..moveTo(-anchorSize, -anchorSize)
        ..lineTo(anchorSize, -anchorSize)
        ..lineTo(anchorSize, anchorSize)
        ..lineTo(-anchorSize, anchorSize)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
