import 'package:eco_toss/features/flame_game/background/background_component.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BackgroundOnlyGame extends FlameGame {
  BackgroundOnlyGame();

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(BackgroundComponent());
    camera.backdrop.add(cloudComponent(speed: 20, size: size));
    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.position = Vector2(0, 0);
  }
}
