import 'package:eco_toss/features/flame_game/ball/ball_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/utils/floor_far_edge.dart';
import 'package:eco_toss/features/flame_game/utils/show_xyz_dimensions.dart';
import 'package:flame/components.dart';

const bool showGameTuningUtils = false;

abstract class BaseEcoTossWorld extends World
    with HasCollisionDetection, HasGameRef {
  @override
  Future<void> onLoad() async {
    final game = findGame()! as BaseEcoTossGame;

    if (showGameTuningUtils) {
      add(FloorFarEdge());
      showXYZDimensions(this);
    }

    final binComponents = createBinComponents(midpointXMetres: 1);
    add(binComponents.backSurfaceComponent);
    add(binComponents.frontSurfaceComponent);
    add(binComponents.holeComponent);

    await add(BallComponent(
      radiusStartMetres: 0.2,
      addScore: game.addScore,
      onMiss: game.onMiss,
      binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
      windSpeedMps2: game.windSpeedMps2,
    ));

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
          windSpeedMps2: game.windSpeedMps2,
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
}
