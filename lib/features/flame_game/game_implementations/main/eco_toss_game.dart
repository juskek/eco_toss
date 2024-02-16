import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/text/typing_text_component.dart';
import 'package:eco_toss/pages/game_page/game_page.dart';
import 'package:flame/components.dart';

class EcoTossGame extends BaseEcoTossGame {
  EcoTossGame(this.gameViewModel) : super(world: EcoTossWorld());
  final GameViewModel gameViewModel;

  late TextComponent highScoreTextComponent;
  late Vector2 textSize;
  late Vector2 textPosition;

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
    await gameViewModel.getPreviousHighScore();

    textSize = Vector2(size.x, size.y * 0.5);
    textPosition = Vector2(0, size.y * 0.8);

    highScoreTextComponent = TypingTextComponent(
      text: 'New high score!',
      size: textSize,
      position: textPosition,
    );
    scoreNotifier.addListener(() async {
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
