import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EcoTossWorld extends World with HasCollisionDetection, HasGameRef {
  final scoreNotifier = ValueNotifier(0);

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  @override
  Future<void> onLoad() async {
    showXYZDimensions();
    // await add(RectangleComponent(
    //   position: Vector2(0, yFloorPixels),
    //   size: Vector2(findGame()!.canvasSize.x, 10),
    //   anchor: Anchor.center,
    // ));
    // await add(BackboardComponent(
    //   size: Vector2(findGame()!.canvasSize.x * 0.3, 100),
    // ));
    // final binComponent =
    //     BinComponent(size: Vector2(findGame()!.canvasSize.x * 0.3, 200));
    // await add(binComponent);
    // await add(BallComponent(
    //   radiusStart: 50,
    //   addScore: addScore,
    // ));

    // final ballNotifier = gameRef.componentsNotifier<BallComponent>();
    // ballNotifier.addListener(() {
    //   final ball = ballNotifier.single;
    //   if (ball == null) {
    //     binComponent.priority = 1;
    //     add(BallComponent(
    //       radiusStart: 50,
    //       addScore: addScore,
    //     ));
    //   }
    //   if (ball != null && ball.zPositionMetres >= zBinStartMetres) {
    //     binComponent.priority = 2;
    //     ball.priority = 1;
    //   }
    // });
  }

  void showXYZDimensions() {
    final canvasWidthX = findGame()!.canvasSize.x;
    final leftX = -canvasWidthX / 2;
    final rightX = canvasWidthX / 2;
    final canvasHeightY = findGame()!.canvasSize.y;
    final bottomY = canvasHeightY / 2;
    final topY = -canvasHeightY / 2;
    for (var x = leftX; x < rightX; x += 100) {
      add(
        TextComponent(
          text: 'xPixels: ${x.toInt()}',
          position: Vector2(x, 0),
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    for (var y = topY; y < bottomY; y += 100) {
      add(
        TextComponent(
          text: 'yPixels: ${y.toInt()}',
          position: Vector2(leftX, y),
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    for (var z = topY; z < bottomY; z += 100) {
      add(
        TextComponent(
          text: 'zPixels: ${z.toInt()}',
          position: Vector2(rightX, z),
          anchor: Anchor.centerRight,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
