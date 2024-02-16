import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/new_user/new_user_local_data_source.dart';
import 'package:eco_toss/data/score/score_local_data_source.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';
import 'package:eco_toss/data/user/user_local_data_source.dart';
import 'package:eco_toss/features/app_version_control/app_version_control_wrapper.dart';
import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:eco_toss/features/flame_game/game_implementations/game_view_model.dart';
import 'package:eco_toss/features/name/name_viewmodel.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nes_ui/nes_ui.dart';

import 'atomic/palette.dart';
import 'features/app_lifecycle/app_lifecycle.dart';
import 'features/player_progress/player_progress.dart';
import 'firebase_options.dart';
import 'pages/settings/settings.dart';
import 'router.dart';

void main() async {
  /// Required for package_info_plus, firebase_auth
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openLazyBox(ScoreLocalDataSource.hiveBoxName);
  await Hive.openLazyBox(UserLocalDataSource.hiveBoxName);
  await Hive.openLazyBox(NewUserLocalDataSource.hiveBoxName);

  configureDependencyInjection(Env.prod);
  await Flame.device.setPortraitUpOnly();
  await Flame.device.fullScreen();
  try {
    await FirebaseAuth.instance.signInAnonymously();

    debugPrint("Signed in with temporary account.");
    final user = FirebaseAuth.instance.currentUser;
    assert(user != null);
    getIt<IUserRepository>().storeUserId(user!.uid);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        debugPrint("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        debugPrint("Unknown error.");
    }
  }
  await EcoTossRouter.init();

  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => Palette()),
          ChangeNotifierProvider(create: (context) => PlayerProgress()),
          Provider(create: (context) => SettingsController()),
          ChangeNotifierProvider(
              create: (context) => getIt<LeaderboardViewModel>()),
          ChangeNotifierProvider(create: (context) => getIt<GameViewModel>()),
          ChangeNotifierProvider(create: (context) => getIt<NameViewModel>()),

          // Set up audio.
          ProxyProvider2<SettingsController, AppLifecycleStateNotifier,
              AudioController>(
            // Ensures that music starts immediately.
            lazy: false,
            create: (context) => AudioController(),
            update: (context, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();

          return MaterialApp.router(
            title: 'Endless Runner',
            theme: flutterNesTheme().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.seed.color,
                background: palette.backgroundMain.color,
              ),
              textTheme: GoogleFonts.aBeeZeeTextTheme().apply(
                bodyColor: palette.text.color,
                displayColor: palette.text.color,
              ),
              // textTheme: GoogleFonts.pressStart2pTextTheme().apply(
              //   bodyColor: palette.text.color,
              //   displayColor: palette.text.color,
              // ),
            ),
            routeInformationProvider:
                EcoTossRouter.instance.routeInformationProvider,
            routeInformationParser:
                EcoTossRouter.instance.routeInformationParser,
            routerDelegate: EcoTossRouter.instance.routerDelegate,
            builder: (context, child) =>
                AppVersionControlWrapper(child: child!),
          );
        }),
      ),
    );
  }
}

class AppViewModel {}
