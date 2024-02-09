import 'package:eco_toss/atomic/page_transition.dart';
import 'package:eco_toss/atomic/palette.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/pages/flame_game/game_screen.dart';
import 'package:eco_toss/pages/game_page/game_page.dart';
import 'package:eco_toss/pages/home_page/HomePage.dart';
import 'package:eco_toss/pages/level_selection/levels.dart';
import 'package:eco_toss/pages/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const GamePage(level: (
    //     number: 1,
    //     winScore: 3,
    //     canSpawnTall: false,
    //   )),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('play'),
            color: context.watch<Palette>().backgroundLevelSelection.color,
            child: const GamePage(level: (
              number: 1,
              winScore: 3,
              canSpawnTall: false,
            )),
          ),
          routes: [
            GoRoute(
              path: 'session/:level',
              pageBuilder: (context, state) {
                final levelNumber = int.parse(state.pathParameters['level']!);
                final level = gameLevels[levelNumber - 1];
                return buildPageTransition<void>(
                  key: const ValueKey('level'),
                  color: context.watch<Palette>().backgroundPlaySession.color,
                  child: GameScreen(level: level),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(
            key: Key('settings'),
          ),
        ),
      ],
    ),
  ],
);
