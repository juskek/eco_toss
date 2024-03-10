import 'package:eco_toss/features/audio/sounds.dart';
import 'package:eco_toss/features/flame_game/background/background_component.dart';
import 'package:eco_toss/features/flame_game/background/generate_cloud_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/utils.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:eco_toss/features/flame_game/text/typing_text_component.dart';
import 'package:eco_toss/pages/game_page/game_page.dart';
import 'package:flame/components.dart';

class EcoTossGame extends BaseEcoTossGame {
  EcoTossGame(this.gameViewModel,
      {required super.spriteViewModel, required super.audioController})
      : super(world: EcoTossWorld());
  final GameViewModel gameViewModel;

  late TextComponent highScoreTextComponent;
  late TextComponent windTextComponent;

  @override
  void onBinned({int amount = 1}) {
    scoreNotifier.value += amount;
    audioController.playSfx(SfxType.score);
  }

  @override
  void onMiss() {
    if (scoreNotifier.value > gameViewModel.previousHighScore) {
      overlays.add(GamePage.submitHighScoreOverlayKey);
      gameViewModel.setPreviousHighScore(scoreNotifier.value);
    }
    scoreNotifier.value = 0;
  }

  @override
  Future<void> onLoad() async {
    EcoTossPositioning.setCanvasSize(canvasSize.y, canvasSize.x);

    overlays.add(GamePage.backButtonKey);
    camera.backdrop.add(BackgroundComponent());
    cloudComponent = generateCloudComponent(speedMps: 0, size: size);
    camera.backdrop.add(cloudComponent!);

    await gameViewModel.getPreviousHighScore();

    highScoreTextComponent = TypingTextComponent(
      text: 'New high score!',
      size: Vector2(size.x, size.y * 0.5),
      position: Vector2(size.x / 2, size.y * 0.8),
    );
    const windText = 'Wind Speed: 0 m/s direction';

    final binBackTopEdgeXYPixels = getBinBackTopEdgePixels();

    final windTextPixelPosition = Vector2(
      binBackTopEdgeXYPixels.x,
      binBackTopEdgeXYPixels.y - TypingTextComponent.fontSize * 3,
    );

    windTextComponent = TypingTextComponent(
      text: windText.replaceFirst('direction', ''),
      size: Vector2(size.x, TypingTextComponent.fontSize * 2),
      position: windTextPixelPosition,
    );

    spriteViewModel.paperBallSprite.addListener(() {
      if (spriteViewModel.paperBallSprite.value != null) {
        world.add(windTextComponent);
      }
    });

    scoreNotifier.addListener(() async {
      windSpeedMps2 = 0;

      if (scoreNotifier.value != 0) {
        windSpeedMps2 = generateRandomWindSpeed();
      }

      final windSpeedTextValue = windSpeedDoubleToPrettyString(windSpeedMps2);

      final windSpeedDirectionText = windSpeedTextValue == '0'
          ? ''
          : windSpeedMps2 > 0
              ? "👉"
              : '👈';

      final windTextWithValue = windText.replaceFirst('0', windSpeedTextValue);
      final windTextWithDirection = windTextWithValue.replaceFirst(
        'direction',
        windSpeedDirectionText,
      );
      windTextComponent.text = windTextWithDirection;
      camera.backdrop.remove(cloudComponent!);
      cloudComponent =
          generateCloudComponent(speedMps: windSpeedMps2, size: size);
      camera.backdrop.add(cloudComponent!);

      if (scoreNotifier.value == gameViewModel.previousHighScore + 1) {
        camera.viewport.add(highScoreTextComponent);
        Future.delayed(const Duration(seconds: 3), () {
          camera.viewport.remove(highScoreTextComponent);
        });
      }

      if (scoreNotifier.value > gameViewModel.previousHighScore) {
        await gameViewModel.setHighScore(scoreNotifier.value);
      }
    });

    return super.onLoad();
  }
}
