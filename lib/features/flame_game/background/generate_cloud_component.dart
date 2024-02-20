import 'package:eco_toss/features/flame_game/background/cloud_component_one.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_three.dart';
import 'package:eco_toss/features/flame_game/background/cloud_component_two.dart';
import 'package:flame/components.dart';

Component generateCloudComponent(
    {required double speedMps, required Vector2 size}) {
  double speedOne = speedMps == 0 ? 0 : speedMps * 15;
  double speedTwo = speedMps == 0 ? 0 : speedMps * 10;
  double speedThree = speedMps == 0 ? 0 : speedMps * 5;
  return PositionComponent(
    position: Vector2(0, 0),
    size: Vector2(size.x, size.y * 0.3),
    children: [
      PositionComponent(
        position: Vector2(0, -20),
        size: Vector2(size.x, size.y * 0.3),
        children: [CloudComponentOne(speed: speedOne)],
      ),
      PositionComponent(
        position: Vector2(0, 50),
        size: Vector2(size.x, size.y * 0.1),
        children: [CloudComponentTwo(speed: speedTwo)],
      ),
      PositionComponent(
        position: Vector2(0, 20),
        size: Vector2(size.x, size.y * 0.2),
        children: [CloudComponentThree(speed: speedThree)],
      ),
    ],
  );
}
