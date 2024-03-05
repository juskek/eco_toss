import 'package:eco_toss/features/audio/sounds.dart';
import 'package:eco_toss/features/flame_game/background/background_component.dart';
import 'package:eco_toss/features/flame_game/background/generate_cloud_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/tutorial/tutorial_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/text/typing_text_component.dart';
import 'package:eco_toss/features/flame_game/throwables/paper_ball_component.dart';
import 'package:eco_toss/pages/tutorial_page/tutorial_page.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TutorialEcoTossGame extends BaseEcoTossGame with HasGameRef {
  TutorialEcoTossGame(
      {required super.audioController, required super.spriteViewModel})
      : super(world: TutorialEcoTossWorld());
  final thrownNotifier = ValueNotifier<bool>(false);
  static TextComponent? instructionsText;
  late Vector2 tutorialTextSize;
  late Vector2 tutorialTextPosition;

  @override
  void onBinned({int amount = 1}) {
    scoreNotifier.value += amount;
    audioController.playSfx(SfxType.score);
  }

  @override
  void onMiss() {}

  @override
  Future<void> onLoad() {
    camera.backdrop.add(BackgroundComponent());
    camera.backdrop.add(generateCloudComponent(speedMps: 0.3, size: size));
    overlays.add(TutorialPage.welcomeOverlayKey);

    tutorialTextSize = Vector2(size.x, size.y * 0.5);
    tutorialTextPosition = Vector2(size.x / 2, size.y * 0.8);

    instructionsText = TypingTextComponent(
      text: 'Swipe to throw the paper ball into the bin!',
      size: tutorialTextSize,
      position: tutorialTextPosition,
    );

    spriteViewModel.paperBallSprite.addListener(() {
      if (spriteViewModel.paperBallSprite.value != null) {
        camera.viewport.add(TutorialEcoTossGame.instructionsText!);
      }
    });

    final ballNotifier = gameRef.componentsNotifier<PaperBallComponent>();
    ballNotifier.addListener(() {
      final ball = ballNotifier.single;
      if (ball == null) {
        return;
      }
      if (ball.isThrown) {
        thrownNotifier.value = true;
      }
    });
    thrownNotifier.addListener(() {
      if (thrownNotifier.value && scoreNotifier.value == 0) {
        camera.viewport.remove(instructionsText!);
        instructionsText = TypingTextComponent(
            text: "Try using long swipes for better accuracy.",
            size: size,
            position: tutorialTextPosition);
        camera.viewport.add(instructionsText!);
      }
    });

    scoreNotifier.addListener(() {
      if (scoreNotifier.value == 1) {
        camera.viewport.remove(instructionsText!);
        instructionsText = TypingTextComponent(
            text: "Score! Let's try to get 3 points.",
            size: size,
            position: tutorialTextPosition);
        camera.viewport.add(instructionsText!);
      }
    });

    scoreNotifier.addListener(() {
      if (scoreNotifier.value == 3) {
        camera.viewport.remove(instructionsText!);
        overlays.add(TutorialPage.readyForOnboardingOverlayKey);
      }
    });
    return super.onLoad();
  }
}
