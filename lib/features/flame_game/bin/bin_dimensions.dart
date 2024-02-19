import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:flame/game.dart';

abstract class BinDimensions {
  static const heightMetres = 0.7;
  static const widthMetres = 0.3;
  static const backSurfaceZMetres = 4.0;
  static const frontSurfaceZMetres = 3.6;
  static const depthMetres = backSurfaceZMetres - frontSurfaceZMetres;
}

({
  BinFrontSurfaceComponent frontSurfaceComponent,
  BinBackSurfaceComponent backSurfaceComponent,
  BinHoleComponent holeComponent,
}) createBinComponents({required double midpointXMetres}) {
  final binHoleCoordinatesMetres =
      BinHoleCoordinatesMetres(midpointXMetres: midpointXMetres);
  return (
    frontSurfaceComponent: BinFrontSurfaceComponent(),
    backSurfaceComponent: BinBackSurfaceComponent(),
    holeComponent: BinHoleComponent(
        midpointXMetres: midpointXMetres,
        binHoleCoordinatesMetres: binHoleCoordinatesMetres),
  );
}

class BinHoleCoordinatesMetres {
  final Vector3 backLeftCornerMetres;
  final Vector3 backRightCornerMetres;
  final Vector3 frontLeftCornerMetres;
  final Vector3 frontRightCornerMetres;

  BinHoleCoordinatesMetres._({
    required this.backLeftCornerMetres,
    required this.backRightCornerMetres,
    required this.frontLeftCornerMetres,
    required this.frontRightCornerMetres,
  });

  factory BinHoleCoordinatesMetres({required double midpointXMetres}) {
    return BinHoleCoordinatesMetres._(
      backLeftCornerMetres: Vector3(
        midpointXMetres - BinDimensions.widthMetres / 2,
        BinDimensions.heightMetres,
        BinDimensions.backSurfaceZMetres,
      ),
      backRightCornerMetres: Vector3(
        midpointXMetres + BinDimensions.widthMetres / 2,
        BinDimensions.heightMetres,
        BinDimensions.backSurfaceZMetres,
      ),
      frontLeftCornerMetres: Vector3(
        midpointXMetres - BinDimensions.widthMetres / 2,
        BinDimensions.heightMetres,
        BinDimensions.frontSurfaceZMetres,
      ),
      frontRightCornerMetres: Vector3(
        midpointXMetres + BinDimensions.widthMetres / 2,
        BinDimensions.heightMetres,
        BinDimensions.frontSurfaceZMetres,
      ),
    );
  }
}
