import 'package:endless_runner/features/flame_game/eco_toss_camera_component.dart';
import 'package:endless_runner/features/flame_game/eco_toss_world.dart';
import 'package:flame/game.dart';

class EcoTossGame extends FlameGame {
  EcoTossGame()
      : super(
          world: EcoTossWorld(),
          camera: EcoTossCameraComponent(),
        );

  @override
  Future<void> onLoad() async {}
}
