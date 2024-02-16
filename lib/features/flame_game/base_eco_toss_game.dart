import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/eco_toss_camera_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class BaseEcoTossGame extends FlameGame<BaseEcoTossWorld> {
  BaseEcoTossGame({super.world})
      : super(
          camera: EcoTossCameraComponent(),
        );

  final scoreNotifier = ValueNotifier(0);

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  void onMiss();

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

    scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${scoreNotifier.value}');
    });
  }
}
