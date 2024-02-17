import 'package:eco_toss/features/dialogs/submit_highscore_dialog.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/pages/flame_game/endless_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../../features/audio/audio_controller.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';
  static const String submitHighScoreOverlayKey = 'submit_high_score';

  @override
  Widget build(BuildContext context) {
    // final audioController = context.read<AudioController>();
    final gameViewModel = context.read<GameViewModel>();
    return Scaffold(
      body: GameWidget<BaseEcoTossGame>(
        key: const Key('play session'),
        game: EcoTossGame(gameViewModel),
        overlayBuilderMap: {
          backButtonKey: (BuildContext context, BaseEcoTossGame game) {
            return Positioned(
              top: 20,
              left: 10,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: GoRouter.of(context).pop,
                child: NesIcon(iconData: NesIcons.leftArrowIndicator),
              ),
            );
          },
          submitHighScoreOverlayKey:
              (BuildContext context, BaseEcoTossGame game) {
            return SubmitHighScoreDialog(onSubmit: () {
              gameViewModel.submitHighScore();
              game.overlays.remove(GamePage.submitHighScoreOverlayKey);
            }, onCancel: () {
              game.overlays.remove(GamePage.submitHighScoreOverlayKey);
            });
          },
        },
      ),
    );
  }
}
