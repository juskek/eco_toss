import 'package:eco_toss/features/flame_game/game_implementations/home_page/background_only_game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

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
            squarishMainArea: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: SpriteAnimationWidget.asset(
                      path: 'throwables/paper_ball.png',
                      playing: true,
                      data: SpriteAnimationData.sequenced(
                        amount: 20,
                        textureSize: Vector2.all(128),
                        texturePosition: Vector2(512, 0),
                        stepTime: 0.1,
                      ),
                    ),
                  ),
                  _gap,
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      'Eco Toss',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.happyMonkey(
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            rectangularMenuArea: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: RiveAnimation.network(
                    'https://cdn.rive.app/animations/vehicles.riv',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                  child: const Text('Play'),
                ),
                _gap,
                TextButton(
                  onPressed: () => GoRouter.of(context).push('/leaderboard'),
                  child: const Text('Leaderboard'),
                ),
                _gap,
                TextButton(
                  onPressed: () => GoRouter.of(context).push('/settings'),
                  child: const Text('Settings'),
                ),
                _gap,
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: settingsController.audioOn,
                    builder: (context, audioOn, child) {
                      return IconButton(
                        onPressed: () => settingsController.toggleAudioOn(),
                        icon:
                            Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                      );
                    },
                  ),
                ),
                _gap,
                const Text('Built with Flame'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
