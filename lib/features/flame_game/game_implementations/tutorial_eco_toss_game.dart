import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/pages/tutorial_page/tutorial_page.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TutorialEcoTossGame extends BaseEcoTossGame {
  static TextComponent? swipeToThrowText;
  @override
  Future<void> onLoad() {
    overlays.add(TutorialPage.welcomeOverlayKey);
    swipeToThrowText = TutorialTextComponent(
      text: 'Swipe to throw the paper ball',
      size: Vector2(size.x, size.y * 0.5),
      position: Vector2(0, size.y * 0.8),
    );

    world.scoreNotifier.addListener(() {
      if (world.scoreNotifier.value == 1) {
        assert(swipeToThrowText != null);
        camera.viewport.remove(swipeToThrowText!);
      }
      if (world.scoreNotifier.value == 3) {
        overlays.add(TutorialPage.readyForOnboardingOverlayKey);
      }
    });
    return super.onLoad();
  }
}

class TutorialTextComponent extends TextBoxComponent {
  TutorialTextComponent({
    required String text,
    required super.size,
    required super.position,
  }) : super(
          text: text,
          align: Anchor.topCenter,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          boxConfig: TextBoxConfig(timePerChar: 0.05),
        );
}
