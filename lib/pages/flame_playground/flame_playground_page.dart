import 'package:endless_runner/pages/flame_game/endless_runner.dart';
import 'package:endless_runner/pages/flame_game/game_win_dialog.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../../features/audio/audio_controller.dart';
import '../../features/player_progress/player_progress.dart';
import '../level_selection/levels.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class FlamePlaygroundPage extends StatelessWidget {
  const FlamePlaygroundPage({required this.level, super.key});

  final GameLevel level;

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Scaffold(
      body: GameWidget<EndlessRunner>(
        key: const Key('play session'),
        game: EndlessRunner(
          level: level,
          playerProgress: context.read<PlayerProgress>(),
          audioController: audioController,
        ),
        overlayBuilderMap: {
          backButtonKey: (BuildContext context, EndlessRunner game) {
            return Positioned(
              top: 20,
              right: 10,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: GoRouter.of(context).pop,
                child: NesIcon(iconData: NesIcons.leftArrowIndicator),
              ),
            );
          },
          winDialogKey: (BuildContext context, EndlessRunner game) {
            return GameWinDialog(
              level: level,
              levelCompletedIn: game.world.levelCompletedIn,
            );
          },
        },
      ),
    );
  }
}
