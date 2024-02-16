import 'package:eco_toss/features/flame_game/ball/ball_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/text/typing_text_component.dart';
import 'package:eco_toss/pages/tutorial_page/tutorial_page.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TutorialEcoTossGame extends BaseEcoTossGame with HasGameRef {
  final thrownNotifier = ValueNotifier<bool>(false);
  static TextComponent? instructionsText;
  late Vector2 tutorialTextSize;
  late Vector2 tutorialTextPosition;
  @override
  Future<void> onLoad() {
    overlays.add(TutorialPage.welcomeOverlayKey);

    tutorialTextSize = Vector2(size.x, size.y * 0.5);
    tutorialTextPosition = Vector2(0, size.y * 0.8);

    instructionsText = TypingTextComponent(
      text: 'Swipe to throw the paper ball',
      size: tutorialTextSize,
      position: tutorialTextPosition,
    );

    final ballNotifier = gameRef.componentsNotifier<BallComponent>();
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
      if (thrownNotifier.value) {
        assert(instructionsText != null);
        camera.viewport.remove(instructionsText!);
        Future.delayed(const Duration(seconds: 2), () {
          if (world.scoreNotifier.value == 0) {
            instructionsText = TypingTextComponent(
                text:
                    "Good throw! To score points, throw the paper ball into the bin. Let's aim for 3 points!",
                size: size,
                position: tutorialTextPosition);
          } else {
            instructionsText = TypingTextComponent(
                text:
                    "Great! You scored a point by throwing the paper ball into the bin! Let's try to get 3 points.",
                size: size,
                position: tutorialTextPosition);
          }
          camera.viewport.add(instructionsText!);
        });
      }
    });

    world.scoreNotifier.addListener(() {
      if (world.scoreNotifier.value == 3) {
        camera.viewport.remove(instructionsText!);
        overlays.add(TutorialPage.readyForOnboardingOverlayKey);
      }
    });
    return super.onLoad();
  }
}
