import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/pages/flame_game/endless_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../features/audio/audio_controller.dart';
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
    // final audioController = context.read<AudioController>();
    return Scaffold(
      body: GameWidget<EcoTossGame>(
        key: const Key('play session'),
        game: EcoTossGame(),
      ),
    );
  }
}
