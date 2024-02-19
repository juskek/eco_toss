import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';

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
}) createBinComponents({required int midpointXMetres}) {
  final holeCoordinates =
      calculateCornerCoordinates(midpointXMetres: midpointXMetres);
  return (
    frontSurfaceComponent: BinFrontSurfaceComponent(),
    backSurfaceComponent: BinBackSurfaceComponent(),
  );
}

({
  double backLeftCorner,
  double backRightCorner,
  double frontLeftCorner,
  double frontRightCorner
}) calculateCornerCoordinates({required int midpointXMetres}) {
  return (
    backLeftCorner: midpointXMetres - BinDimensions.widthMetres / 2,
    backRightCorner: midpointXMetres + BinDimensions.widthMetres / 2,
    frontLeftCorner: midpointXMetres - BinDimensions.widthMetres / 2,
    frontRightCorner: midpointXMetres + BinDimensions.widthMetres / 2,
  );
}
