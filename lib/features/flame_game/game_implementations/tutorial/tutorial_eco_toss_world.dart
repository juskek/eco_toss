import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/throwables/paper_ball_component.dart';

class TutorialEcoTossWorld extends BaseEcoTossWorld {
  @override
  Future<void> onLoad() async {
    final game = findGame()! as BaseEcoTossGame;

    final binComponents =
        createBinComponents(binType: BinType.paper, midpointXMetres: 1);
    add(binComponents.backSurfaceComponent);
    add(binComponents.frontSurfaceComponent);
    add(binComponents.holeComponent);

    await add(PaperBallComponent(
      radiusStartMetres: 0.2,
      addScore: game.addScore,
      onMiss: game.onMiss,
      binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
      windSpeedMps2: game.windSpeedMps2,
    ));

    final ballNotifier = gameRef.componentsNotifier<PaperBallComponent>();
    ballNotifier.addListener(() {
      final ball = ballNotifier.single;
      if (ball == null) {
        binComponents.frontSurfaceComponent.priority = 1;
        add(PaperBallComponent(
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
