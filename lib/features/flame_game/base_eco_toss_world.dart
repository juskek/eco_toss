import 'package:eco_toss/features/flame_game/ball/ball_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:eco_toss/features/flame_game/room/floor_far_edge.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

abstract class BaseEcoTossWorld extends World
    with HasCollisionDetection, HasGameRef {
  @override
  Future<void> onLoad() async {
    final game = findGame()! as BaseEcoTossGame;

    add(FloorFarEdge());

    final binComponents = createBinComponents(midpointXMetres: 1);
    add(binComponents.backSurfaceComponent);
    add(binComponents.frontSurfaceComponent);
    add(binComponents.holeComponent);

    await add(BallComponent(
      radiusStartMetres: 0.2,
      addScore: game.addScore,
      onMiss: game.onMiss,
      binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
    ));

    showXYZDimensions();

    final ballNotifier = gameRef.componentsNotifier<BallComponent>();
    ballNotifier.addListener(() {
      final ball = ballNotifier.single;
      if (ball == null) {
        binComponents.frontSurfaceComponent.priority = 1;
        add(BallComponent(
          radiusStartMetres: 0.2,
          addScore: game.addScore,
          onMiss: game.onMiss,
          binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
        ));
      }
      if (ball != null &&
          ball.zPositionMetres >=
              EcoToss3DSpace.zMaxMetres - BinDimensions.depthMetres) {
        binComponents.frontSurfaceComponent.priority = 2;
        ball.priority = 1;
      }
    });
  }

  void showXYZDimensions() {
    for (var xMetres = EcoToss3DSpace.xMinMetres;
        xMetres <= EcoToss3DSpace.xMaxMetres;
        xMetres += 0.5) {
      final xPixels = EcoTossPositioning.xyzMetresToXyPixels(
              Vector3(xMetres, EcoToss3DSpace.yMidMetres, 0))
          .x;

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
      final yPixels = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
              EcoToss3DSpace.xMinMetres, yMetres, EcoToss3DSpace.zMinMetres))
          .y;
      add(
        TextComponent(
          text: 'y: ${yMetres.toStringAsFixed(1)}m, ${yPixels.toInt()}px',
          position: Vector2(EcoTossPositioning.leftX, yPixels),
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
      final zPixels = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
              EcoToss3DSpace.xMaxMetres, EcoToss3DSpace.yMinMetres, zMetres))
          .y;

      add(
        TextComponent(
          text: 'zMetres: ${zMetres.toStringAsFixed(1)}m, ${zPixels.toInt()}px',
          position: Vector2(EcoTossPositioning.rightX, zPixels),
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
