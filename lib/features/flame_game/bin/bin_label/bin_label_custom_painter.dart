import 'dart:math';
import 'dart:ui' as ui show Image;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BinLabelCustomPainter extends CustomPainter {
  final ui.Image image;
  final Vector2 positionPixels;

  final bool _showAnchor = false;
  final scale = 0.12;
  final paddingFromTopEdgeOfBin = 3;
  final rotationXDegrees = 10;

  const BinLabelCustomPainter(
      {required this.image, required this.positionPixels});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.translate(
        positionPixels.x, positionPixels.y + paddingFromTopEdgeOfBin);

    final rotationXRadians = rotationXDegrees * (pi / 180);
    canvas
      ..scale(scale, scale)
      ..transform(Matrix4.rotationX(rotationXRadians).storage);
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
