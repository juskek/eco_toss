import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/throwables/ball_component.dart';
import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

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

    final throwableNotifier = gameRef.componentsNotifier<ThrowableComponent>();
    throwableNotifier.addListener(() {
      final throwable = throwableNotifier.single;
      if (throwable == null) {
        binComponents.frontSurfaceComponent.priority = 1;
        game.gameViewModel.cycleThrowables();
        switch (game.gameViewModel.currentThrowableType) {
          case ThrowableType.banana:
            print('banana');
            break;
          case ThrowableType.can:
            print('can');
            break;
          case ThrowableType.glassBottle:
            print('glassBottle');
            break;
          case ThrowableType.paperBall:
            add(BallComponent(
              radiusStartMetres: 0.2,
              addScore: game.addScore,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;
          case ThrowableType.plasticBottle:
            print('plasticBottle');
            break;

          default:
            throw UnimplementedError();
        }
      }
      if (throwable != null &&
          throwable.zPositionMetres >=
              EcoToss3DSpace.zMaxMetres - BinDimensions.depthMetres) {
        binComponents.frontSurfaceComponent.priority = 2;
        throwable.priority = 1;
      }
    });
  }
}
