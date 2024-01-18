import 'package:endless_runner/features/flame_game/backboard/backboard.dart';
import 'package:endless_runner/features/flame_game/ball/ball.dart';
import 'package:endless_runner/features/flame_game/bin/bin_component.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/components.dart';

class EcoTossWorld extends World with HasCollisionDetection, HasGameRef {
  @override
  Future<void> onLoad() async {
    const yVelocity = -20.0;
    const zVelocity = 50.0;
    await add(RectangleComponent(
      position: Vector2(0, yFloorPixels),
      size: Vector2(findGame()!.canvasSize.x, 10),
      anchor: Anchor.center,
    ));
    await add(BackboardComponent(
      size: Vector2(findGame()!.canvasSize.x * 0.3, 100),
    ));
    final binComponent =
        BinComponent(size: Vector2(findGame()!.canvasSize.x * 0.3, 200));
    await add(binComponent);
    await add(BallComponent(
        radiusStart: 50,
        xVelocity: 0,
        yVelocity: yVelocity,
        zVelocity: zVelocity));
    final ballNotifier = gameRef.componentsNotifier<BallComponent>();
    ballNotifier.addListener(() {
      final ball = ballNotifier.single;
      if (ball == null) {
        binComponent.priority = 1;
        add(BallComponent(
            radiusStart: 50,
            xVelocity: 0,
            yVelocity: yVelocity,
            zVelocity: zVelocity));
      }
      if (ball != null && ball.zPosition >= zBinStartMetres) {
        print('ball behind bin');
        binComponent.priority = 2;
        ball.priority = 1;
      }
    });
  }
}
