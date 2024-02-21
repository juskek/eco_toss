import 'package:eco_toss/atomic/atoms/eco_toss_logo_atom.dart';
import 'package:eco_toss/atomic/atoms/eco_toss_title_atom.dart';
import 'package:eco_toss/features/flame_game/game_implementations/home_page/background_only_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/responsive_screen.dart';
import '../../features/audio/audio_controller.dart';
import '../../features/audio/sounds.dart';
import '../settings/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: BackgroundOnlyGame()),
          ResponsiveScreen(
            squarishMainArea: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EcoTossLogoAtom(),
                  _gap,
                  EcoTossTitleAtom(),
                ],
              ),
            ),
            rectangularMenuArea: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  child: const Text('Play'),
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                ),
                _gap,
                FilledButton.tonal(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).push('/leaderboard');
                  },
                  child: const Text('Leaderboard'),
                ),
                _gap,
                FilledButton.tonal(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).push('/settings');
                  },
                  child: const Text('Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
