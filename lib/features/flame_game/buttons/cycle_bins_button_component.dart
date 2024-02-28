import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class CycleBinsButtonComponent extends ButtonComponent {
  CycleBinsButtonComponent(
    this.gameViewModel, {
    required this.audioController,
  }) : super(
          size: Vector2(100, 100),
          anchor: Anchor.center,
        );

  final GameViewModel gameViewModel;
  final AudioController audioController;

  @override
  void onLoad() {
    final game = findGame()!;
    position = Vector2(game.size.x / 2, game.size.y - 80);
    button = TextComponent(text: 'Cycle Bins');
    super.onLoad();
  }

  @override
  void onTapUp(event) {
    gameViewModel.cycleBins();
    // audioController.playSound('cycle_bins');
    return super.onTapUp(event);
  }
}
