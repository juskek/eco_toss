import 'package:eco_toss/features/flame_game/eco_toss_camera_component.dart';
import 'package:eco_toss/features/flame_game/eco_toss_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class EcoTossGame extends FlameGame<EcoTossWorld> {
  EcoTossGame()
      : super(
          world: EcoTossWorld(),
          camera: EcoTossCameraComponent(),
        );

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.position = Vector2(0, 0);
    const scoreText = 'Recycled: 0';

    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreComponent = TextComponent(
      text: scoreText,
      position: Vector2.all(30),
      textRenderer: textRenderer,
    );

    camera.viewport.add(scoreComponent);

    world.scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${world.scoreNotifier.value}');
    });
  }
}
