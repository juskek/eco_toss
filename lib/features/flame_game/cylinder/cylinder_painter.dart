import 'dart:math';

import 'package:flutter/material.dart';

class CylinderCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintStyle = Paint()..color = Colors.red;
    canvas
      ..transform(Matrix4.rotationX(pi / 4).storage)
      ..drawRect(Rect.fromCenter(center: Offset.zero, width: 30, height: 30),
          paintStyle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
