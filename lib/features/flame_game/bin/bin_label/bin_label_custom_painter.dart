import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';

class BinLabelCustomPainter extends CustomPainter {
  final ui.Image image;
  const BinLabelCustomPainter({required this.image});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    const scale = 0.15;
    canvas.scale(scale, scale);
    canvas.drawImage(image, Offset.zero, Paint());
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
