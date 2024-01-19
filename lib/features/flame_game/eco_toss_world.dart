import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:endless_runner/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EcoTossWorld extends World with HasCollisionDetection, HasGameRef {
  final scoreNotifier = ValueNotifier(0);

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  @override
  Future<void> onLoad() async {
    final canvasSize = findGame()!.canvasSize;
    EcoTossPostioning.setCanvasSize(canvasSize.y, canvasSize.x);
    // await add(RectangleComponent(
    //   position: Vector2(0, 0),
    //   size: Vector2(canvasSize.x, canvasSize.y),
    //   anchor: Anchor.center,
    // ));
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
    for (var xMetres = EcoToss3DSpace.xMinMetres;
        xMetres <= EcoToss3DSpace.xMaxMetres;
        xMetres += 0.5) {
      final xPixels = EcoTossPostioning.xMetresToXPixels(xMetres);

      add(
        TextComponent(
          text: 'x: ${xMetres.toStringAsFixed(1)}m, ${xPixels.toInt()}px',
          position: Vector2(xPixels, 0),
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
    for (var yMetres = EcoToss3DSpace.yMinMetres;
        yMetres <= EcoToss3DSpace.yMaxMetres;
        yMetres += 0.5) {
      final yPixels = EcoTossPostioning.yMetresToYPixels(yMetres);
      add(
        TextComponent(
          text: 'y: ${yMetres.toStringAsFixed(1)}m, ${yPixels.toInt()}px',
          position: Vector2(leftX, yPixels),
          anchor: Anchor.bottomLeft,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    for (var zMetres = EcoToss3DSpace.zMinMetres;
        zMetres <= EcoToss3DSpace.zMaxMetres;
        zMetres += 0.5) {
      final zPixels = EcoTossPostioning.zMetresToZPixels(zMetres);

      add(
        TextComponent(
          text: 'zMetres: ${zMetres.toStringAsFixed(1)}m, ${zPixels.toInt()}px',
          position: Vector2(rightX, zPixels),
          anchor: Anchor.bottomRight,
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
