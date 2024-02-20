import 'package:eco_toss/features/flame_game/background/cloud_component_one.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_three.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_two.dart';
import 'package:flame/components.dart';

Component cloudComponent({required double speed, required Vector2 size}) {
  return PositionComponent(
    position: Vector2(0, 0),
    size: Vector2(size.x, size.y * 0.3),
    children: [
      PositionComponent(
        position: Vector2(0, -20),
        size: Vector2(size.x, size.y * 0.3),
        children: [CloudComponentOne(speed: 20)],
      ),
      PositionComponent(
        position: Vector2(0, 0),
        size: Vector2(size.x, size.y * 0.1),
        children: [CloudComponentTwo(speed: 40)],
      ),
      PositionComponent(
        position: Vector2(0, 20),
        size: Vector2(size.x, size.y * 0.2),
        children: [CloudComponentThree(speed: 60)],
      ),
    ],
  );
}
