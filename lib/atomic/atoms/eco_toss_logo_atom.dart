import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class EcoTossLogoAtom extends StatelessWidget {
  const EcoTossLogoAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: SpriteAnimationWidget.asset(
        path: 'throwables/paper_ball.png',
        playing: true,
        data: SpriteAnimationData.sequenced(
          amount: 20,
          textureSize: Vector2.all(128),
          texturePosition: Vector2(512, 0),
          stepTime: 0.1,
        ),
      ),
    );
  }
}
