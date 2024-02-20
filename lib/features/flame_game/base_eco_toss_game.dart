import 'package:eco_toss/features/flame_game/background/background_component.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_one.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_three.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_two.dart';
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
    await camera.backdrop.add(BackgroundComponent());
    camera.backdrop.add(PositionComponent(
      position: Vector2(0, 0),
      size: Vector2(size.x, size.y * 0.3),
      children: [
        PositionComponent(
          position: Vector2(0, -20),
          size: Vector2(size.x, size.y * 0.3),
          children: [CloudComponentOne(speed: 20)],
        ),
        PositionComponent(
          position: Vector2(0, 0),
          size: Vector2(size.x, size.y * 0.1),
          children: [CloudComponentTwo(speed: 40)],
        ),
        PositionComponent(
          position: Vector2(0, 20),
          size: Vector2(size.x, size.y * 0.2),
          children: [CloudComponentThree(speed: 60)],
        ),
      ],
    ));
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
