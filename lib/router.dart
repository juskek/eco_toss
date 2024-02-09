import 'package:eco_toss/atomic/page_transition.dart';
import 'package:eco_toss/atomic/palette.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/pages/game_page/game_page.dart';
import 'package:eco_toss/pages/home_page/home_page.dart';
import 'package:eco_toss/pages/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('play'),
            color: context.watch<Palette>().backgroundLevelSelection.color,
            child: const GamePage(),
          ),
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
