import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_component.dart';
import 'package:eco_toss/features/flame_game/bin/create_bin_components.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/throwables/banana_component.dart';
import 'package:eco_toss/features/flame_game/throwables/can_component.dart';
import 'package:eco_toss/features/flame_game/throwables/glass_bottle_component.dart';
import 'package:eco_toss/features/flame_game/throwables/paper_ball_component.dart';
import 'package:eco_toss/features/flame_game/throwables/plastic_bottle_component.dart';
import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class EcoTossWorld extends BaseEcoTossWorld {
  late ({
    BinLabelComponent binLabelComponent,
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
    add(binComponents.binLabelComponent);
    add(binComponents.holeComponent);

    game.gameViewModel.currentBinType.addListener(
      () {
        remove(binComponents.backSurfaceComponent);
        remove(binComponents.frontSurfaceComponent);
        remove(binComponents.binLabelComponent);
        remove(binComponents.holeComponent);
        binComponents = createBinComponents(
            binType: game.gameViewModel.currentBinType.value,
            midpointXMetres: 1);
        add(binComponents.backSurfaceComponent);
        add(binComponents.frontSurfaceComponent);
        add(binComponents.binLabelComponent);
        add(binComponents.holeComponent);
      },
    );

    await add(CanComponent(
      onBinned: game.onBinned,
      onMiss: game.onMiss,
      binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
      windSpeedMps2: game.windSpeedMps2,
    ));

    final throwableNotifier = gameRef.componentsNotifier<ThrowableComponent>();
    throwableNotifier.addListener(() {
      final throwable = throwableNotifier.single;
      if (throwable == null) {
        binComponents.frontSurfaceComponent.priority = 1;
        binComponents.binLabelComponent.priority = 1;
        game.gameViewModel.cycleThrowablesRandomly();
        switch (game.gameViewModel.currentThrowableType) {
          case ThrowableType.banana:
            add(BananaComponent(
              onBinned: game.onBinned,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;
          case ThrowableType.can:
            add(CanComponent(
              onBinned: game.onBinned,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;
          case ThrowableType.glassBottle:
            add(GlassBottleComponent(
              onBinned: game.onBinned,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;
          case ThrowableType.paperBall:
            add(PaperBallComponent(
              onBinned: game.onBinned,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;
          case ThrowableType.plasticBottle:
            add(PlasticBottleComponent(
              onBinned: game.onBinned,
              onMiss: game.onMiss,
              binHoleCoordinatesMetres: binComponents.binHoleCoordinatesMetres,
              windSpeedMps2: game.windSpeedMps2,
            ));
            break;

          default:
            throw UnimplementedError();
        }
      }
      if (throwable != null &&
          throwable.zPositionMetres >=
              EcoToss3DSpace.zMaxMetres - BinDimensions.depthMetres) {
        binComponents.frontSurfaceComponent.priority = 2;
        binComponents.binLabelComponent.priority = 2;
        throwable.priority = 1;
      }
    });
  }
}
