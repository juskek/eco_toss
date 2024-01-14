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
    const width = 20.0;
    const height = 30.0;
    const circleRadius = width / 2;
    const circleOffset = height / 2;
    final circleOffsetByRotation = circleOffset * (1 - cos(rotationX));
    final adjustedCircleOffset = circleOffset - circleOffsetByRotation;

    final circleRotationX = rotationX + pi / 2;

    final rectangleRotationX = rotationX;
    final rectangleRotationY =
        rotationX % pi == 0 && rotationZ == 0 ? 0.0 : rotationY;
    canvas.save();
    canvas
      ..transform(Matrix4.rotationX(circleRotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawCircle(
          Offset(0, adjustedCircleOffset), circleRadius, redPaintStyle);
    canvas.restore();
    canvas.save();
    canvas
      ..transform(Matrix4.rotationX(rectangleRotationX).storage)
      ..transform(Matrix4.rotationY(rectangleRotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawRect(
          Rect.fromCenter(center: Offset.zero, width: width, height: height),
          paintStyle);
    canvas.restore();
    canvas.save();
    canvas
      ..transform(Matrix4.rotationX(circleRotationX).storage)
      ..transform(Matrix4.rotationY(rotationY).storage)
      ..transform(Matrix4.rotationZ(rotationZ).storage)
      ..drawCircle(
          Offset(0, -adjustedCircleOffset), circleRadius, redPaintStyle);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
