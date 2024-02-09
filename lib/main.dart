import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/app_version_control/app_version_control_wrapper.dart';
import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';

import 'atomic/palette.dart';
import 'features/app_lifecycle/app_lifecycle.dart';
import 'features/player_progress/player_progress.dart';
import 'firebase_options.dart';
import 'pages/settings/settings.dart';
import 'router.dart';

void main() async {
  /// Required for package_info_plus
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencyInjection(Env.prod);
  await Flame.device.setPortraitUpOnly();
  await Flame.device.fullScreen();
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
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            builder: (context, child) =>
                AppVersionControlWrapper(child: child!),
          );
        }),
      ),
    );
  }
}

class AppViewModel {}
