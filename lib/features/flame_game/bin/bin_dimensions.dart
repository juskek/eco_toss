import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';

abstract class BinDimensions {
  static const heightMetres = 0.55;
  static const widthMetres = 0.55;
  static const backSurfaceZMetres = 4.0;
  static const frontSurfaceZMetres = 3.4;
  static const depthMetres = backSurfaceZMetres - frontSurfaceZMetres;

  /// The scale factor for the bin's back surface image.
  /// This is used to scale the image to match the bin's logical size (in metres).
  static const binBackSurfaceImageScale = 0.25;
  static const binFrontSurfaceImageScale = 0.25;
  static const binBackSurfaceImageYCorrectionPixels = 50.0;
  static const binFrontSurfaceImageYCorrectionPixels = 5.0;
}

({
  BinFrontSurfaceComponent frontSurfaceComponent,
  BinBackSurfaceComponent backSurfaceComponent,
  BinHoleComponent holeComponent,
  BinHoleCoordinatesMetres binHoleCoordinatesMetres,
}) createBinComponents({required double midpointXMetres}) {
  final binHoleCoordinatesMetres =
      BinHoleCoordinatesMetres(midpointXMetres: midpointXMetres);
  return (
    frontSurfaceComponent: BinFrontSurfaceComponent(),
    backSurfaceComponent: BinBackSurfaceComponent(),
    holeComponent: BinHoleComponent(
        midpointXMetres: midpointXMetres,
        binHoleCoordinatesMetres: binHoleCoordinatesMetres),
    binHoleCoordinatesMetres: binHoleCoordinatesMetres,
  );
}
