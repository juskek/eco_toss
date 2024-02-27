import 'package:eco_toss/features/flame_game/ball/ball_component.dart';
import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';

class EcoTossWorld extends BaseEcoTossWorld {
  late ({
    BinFrontSurfaceComponent frontSurfaceComponent,
    BinBackSurfaceComponent backSurfaceComponent,
    BinHoleComponent holeComponent,
    BinHoleCoordinatesMetres binHoleCoordinatesMetres,
  }) binComponents;
  @override
  Future<void> onLoad() async {
    final game = findGame()! as EcoTossGame;
    binComponents = createBinComponents(
        binType: game.gameViewModel.currentBinType.value, midpointXMetres: 1);

    add(binComponents.backSurfaceComponent);
    add(binComponents.frontSurfaceComponent);
    add(binComponents.holeComponent);

    game.gameViewModel.currentBinType.addListener(
      () {
        remove(binComponents.backSurfaceComponent);
        remove(binComponents.frontSurfaceComponent);
        remove(binComponents.holeComponent);
        binComponents = createBinComponents(
            binType: game.gameViewModel.currentBinType.value,
            midpointXMetres: 1);
        add(binComponents.backSurfaceComponent);
        add(binComponents.frontSurfaceComponent);
        add(binComponents.holeComponent);
      },
    );

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
