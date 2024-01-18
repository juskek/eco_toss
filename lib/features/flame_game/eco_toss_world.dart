import 'package:endless_runner/features/flame_game/backboard/backboard.dart';
import 'package:endless_runner/features/flame_game/ball/ball.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/components.dart';

class EcoTossWorld extends World with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await add(BackboardComponent(size: findGame()!.canvasSize * 0.3));
    await add(BallComponent(
        radiusStart: 50, xVelocity: 0, yVelocity: -10, zVelocity: 25));
    add(RectangleComponent(
      position: Vector2(0, yFloor),
      size: Vector2(findGame()!.canvasSize.x, 10),
      anchor: Anchor.center,
    ));
  }
}
