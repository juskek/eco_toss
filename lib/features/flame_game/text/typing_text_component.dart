import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TypingTextComponent extends TextBoxComponent {
  static const double fontSize = 30;
  TypingTextComponent({
    required String text,
    required super.size,
    required super.position,
  }) : super(
          text: text,
          align: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: 'Happy Monkey',
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
          boxConfig: TextBoxConfig(timePerChar: 0.05),
        );
}
