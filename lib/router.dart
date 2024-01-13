import 'package:endless_runner/pages/cylinder_playground/cylinder_playground_page.dart';
import 'package:go_router/go_router.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CylinderPlaygroundPage(),
    ),
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
    //   routes: [
    //     GoRoute(
    //       path: 'play',
    //       pageBuilder: (context, state) => buildPageTransition<void>(
    //         key: const ValueKey('play'),
    //         color: context.watch<Palette>().backgroundLevelSelection.color,
    //         child: const LevelSelectionScreen(
    //           key: Key('level selection'),
    //         ),
    //       ),
    //       routes: [
    //         GoRoute(
    //           path: 'session/:level',
    //           pageBuilder: (context, state) {
    //             final levelNumber = int.parse(state.pathParameters['level']!);
    //             final level = gameLevels[levelNumber - 1];
    //             return buildPageTransition<void>(
    //               key: const ValueKey('level'),
    //               color: context.watch<Palette>().backgroundPlaySession.color,
    //               child: GameScreen(level: level),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: 'settings',
    //       builder: (context, state) => const SettingsScreen(
    //         key: Key('settings'),
    //       ),
    //     ),
    //   ],
    // ),
  ],
);
