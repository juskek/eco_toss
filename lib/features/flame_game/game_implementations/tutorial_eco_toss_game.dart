import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/pages/tutorial_page/tutorial_page.dart';

class TutorialEcoTossGame extends BaseEcoTossGame {
  @override
  Future<void> onLoad() {
    overlays.add(TutorialPage.welcomeOverlayKey);
    world.scoreNotifier.addListener(() {
      if (world.scoreNotifier.value == 3) {
        overlays.add(TutorialPage.readyForOnboardingOverlayKey);
      }
    });
    return super.onLoad();
  }
}
