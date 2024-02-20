import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TypingTextComponent extends TextBoxComponent {
  TypingTextComponent({
    required String text,
    required super.size,
    required super.position,
  }) : super(
          text: text,
          align: Anchor.topCenter,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: 'Happy Monkey',
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          boxConfig: TextBoxConfig(timePerChar: 0.05),
        );
}
