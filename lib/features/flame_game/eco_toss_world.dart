import 'package:endless_runner/features/flame_game/backboard/backboard.dart';
import 'package:endless_runner/features/flame_game/ball/ball.dart';
import 'package:endless_runner/features/flame_game/bin/bin_component.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EcoTossWorld extends World with HasCollisionDetection, HasGameRef {
  final scoreNotifier = ValueNotifier(0);

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  @override
  Future<void> onLoad() async {
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
      addScore: addScore,
    ));

    final ballNotifier = gameRef.componentsNotifier<BallComponent>();
    ballNotifier.addListener(() {
      final ball = ballNotifier.single;
      if (ball == null) {
        binComponent.priority = 1;
        add(BallComponent(
          radiusStart: 50,
          addScore: addScore,
        ));
      }
      if (ball != null && ball.zPosition >= zBinStartMetres) {
        binComponent.priority = 2;
        ball.priority = 1;
      }
    });
  }
}
