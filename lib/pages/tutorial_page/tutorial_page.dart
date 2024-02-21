import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/new_user/i_new_user_repository.dart';
import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:eco_toss/features/dialogs/onboarding_dialog.dart';
import 'package:eco_toss/features/dialogs/welcome_dialog.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/tutorial/tutorial_eco_toss_game.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  static const String welcomeOverlayKey = 'welcome';
  static const String readyForOnboardingOverlayKey = 'ready_for_onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<BaseEcoTossGame>(
        key: const Key('tutorial'),
        game: TutorialEcoTossGame(
            audioController: context.read<AudioController>()),
        overlayBuilderMap: {
          welcomeOverlayKey: (BuildContext context, BaseEcoTossGame game) {
            return WelcomeDialog(
              onPressed: () {
                game.overlays.remove(welcomeOverlayKey);
                assert(TutorialEcoTossGame.instructionsText != null);
                game.camera.viewport.add(TutorialEcoTossGame.instructionsText!);
              },
            );
          },
          readyForOnboardingOverlayKey:
              (BuildContext context, BaseEcoTossGame game) {
            return OnboardingDialog(
              onPressed: () {
                getIt<INewUserRepository>().setHasPlayedTutorial(true);
                context.go('/onboarding');
              },
            );
          },
        },
      ),
    );
  }
}
