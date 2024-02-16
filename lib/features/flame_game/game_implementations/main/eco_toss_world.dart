import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';

class EcoTossWorld extends BaseEcoTossWorld {
  @override
  void resetScore() {
    scoreNotifier.value = 0;
  }
}
