import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/eco_toss_camera_component.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/sprite_view_model.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:eco_toss/features/flame_game/text/typing_text_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class BaseEcoTossGame extends FlameGame<BaseEcoTossWorld> {
  BaseEcoTossGame(
      {required this.audioController,
      required this.spriteViewModel,
      super.world})
      : super(
          camera: EcoTossCameraComponent(),
        );

  final SpriteViewModel spriteViewModel;

  double windSpeedMps2 = 0;
  Component? cloudComponent;

  final scoreNotifier = ValueNotifier(0);

  final AudioController audioController;

  void onBinned({int amount = 1});

  void onMiss();

  @override
  Future<void> onLoad() async {
    spriteViewModel.loadSpriteAnimationsToGame(this);

    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.position = Vector2(0, 0);

    EcoTossPositioning.setCanvasSize(canvasSize.y, canvasSize.x);

    const scoreText = 'Recycled: 0';

    final binBackTopEdgeXYPixels = getBinBackTopEdgePixels();

    final scoreTextPixelPosition = Vector2(
      binBackTopEdgeXYPixels.x,
      binBackTopEdgeXYPixels.y - TypingTextComponent.fontSize,
    );

    final scoreComponent = TextComponent(
      text: scoreText,
      position: scoreTextPixelPosition,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'Happy Monkey',
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );

    world.add((scoreComponent));

    scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${scoreNotifier.value}');
    });

    final loadingTextComponent = TypingTextComponent(
      text: 'Loading assets...',
      size: Vector2(size.x, size.y * 0.5),
      position: Vector2(size.x / 2, size.y * 0.6),
    );

    camera.viewport.add(loadingTextComponent);

    spriteViewModel.paperBallSprite.addListener(() {
      if (spriteViewModel.paperBallSprite.value != null) {
        camera.viewport.remove(loadingTextComponent);
      }
    });
  }
}
