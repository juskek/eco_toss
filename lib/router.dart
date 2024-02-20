import 'package:eco_toss/atomic/page_transition.dart';
import 'package:eco_toss/atomic/palette.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/new_user/i_new_user_repository.dart';
import 'package:eco_toss/pages/game_page/game_page.dart';
import 'package:eco_toss/pages/home_page/home_page.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_page.dart';
import 'package:eco_toss/pages/onboarding/onboarding_page.dart';
import 'package:eco_toss/pages/settings/settings_page.dart';
import 'package:eco_toss/pages/tutorial_page/tutorial_page.dart';
import 'package:go_router/go_router.dart';

abstract class EcoTossRouter {
  static String? _initialRoute;
  static Future<void> init() async {
    await _getInitialRoute();
  }

  static Future<void> _getInitialRoute() async {
    if (!(await getIt<INewUserRepository>().hasPlayedTutorial)) {
      _initialRoute = '/tutorial';
      return;
    }
    if (!(await getIt<INewUserRepository>().hasOnboarded)) {
      _initialRoute = '/onboarding';
      return;
    }
    _initialRoute = '/';
  }

  static GoRouter? _instance;

  static GoRouter get instance {
    assert(_initialRoute != null,
        'Initial route is null, did you forget to call EcoTossRouter.init()?');
    _instance ??= GoRouter(
      initialLocation: '/',
      // initialLocation: _initialRoute,
      routes: [
        GoRoute(
            path: '/tutorial',
            builder: (context, state) => const TutorialPage()),
        GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboardingPage()),
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
              builder: (context, state) => const SettingsPage(
                key: Key('settings'),
              ),
            ),
            GoRoute(
              path: 'leaderboard',
              builder: (context, state) => const LeaderboardPage(
                key: Key('leaderboard'),
              ),
            ),
          ],
        ),
      ],
    );
    return _instance!;
  }
}
