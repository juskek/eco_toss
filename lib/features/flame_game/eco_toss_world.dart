import 'package:endless_runner/features/flame_game/cylinder/cylinder_component.dart';
import 'package:flame/components.dart';

class EcoTossWorld extends World {
  @override
  Future<void> onLoad() async {
    await add(PositionComponent(position: Vector2(0, 0), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
    await add(PositionComponent(position: Vector2(100, 100), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
    await add(PositionComponent(position: Vector2(200, 200), children: [
      CylinderComponent(rotationX: 0, rotationY: 0, rotationZ: 0)
    ]));
  }
}
