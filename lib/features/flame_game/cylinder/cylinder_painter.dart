import 'dart:math';

import 'package:flutter/material.dart';

class CylinderCustomPainter extends CustomPainter {
  CylinderCustomPainter(
      {required this.rotationX,
      required this.rotationY,
      required this.rotationZ});
  final double rotationX;
  final double rotationY;
  final double rotationZ;
  @override
  void paint(Canvas canvas, Size size) {
    final paintStyle = Paint()..color = Colors.red;
    final redPaintStyle = Paint()..color = Colors.grey.shade300;
    const circleOffset = 30.0;

    final circleRotationX = rotationX + pi / 2;
    final circleRotationY = rotationY;
    canvas.save();
    canvas
      ..transform(Matrix4.rotationX(rotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawCircle(const Offset(0, circleOffset), 15, redPaintStyle);
    canvas.restore();
    canvas.save();
    canvas
      ..transform(Matrix4.rotationX(rotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawRect(Rect.fromCenter(center: Offset.zero, width: 30, height: 60),
          paintStyle);
    canvas.restore();
    canvas.save();
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
