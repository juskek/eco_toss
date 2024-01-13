import 'dart:math';

import 'package:flutter/material.dart';

class CylinderCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintStyle = Paint()..color = Colors.white;
    final redPaintStyle = Paint()..color = Colors.red;
    const circleOffset = 30.0;
    const rotationX = pi / 4;
    const rotationY = pi / 4;
    const rotationZ = pi / 4;
    canvas
      ..transform(Matrix4.rotationX(rotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawCircle(const Offset(0, circleOffset), 15, redPaintStyle);
    canvas.restore();
    canvas
      ..transform(Matrix4.rotationX(rotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawRect(Rect.fromCenter(center: Offset.zero, width: 30, height: 60),
          paintStyle);
    canvas.restore();
    canvas
      ..transform(Matrix4.rotationX(rotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawCircle(const Offset(0, -circleOffset), 15, redPaintStyle);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
