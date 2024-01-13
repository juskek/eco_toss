import 'package:endless_runner/features/cylinder/cylinder_world.dart';
import 'package:flame/game.dart';

class CylinderGame extends FlameGame {
  CylinderGame()
      : super(
          world: CylinderWorld(),
        );

  @override
  Future<void> onLoad() async {}
}
