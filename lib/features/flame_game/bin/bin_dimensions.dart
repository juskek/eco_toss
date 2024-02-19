import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';

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
