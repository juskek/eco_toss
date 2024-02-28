import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_component.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';

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
  BinLabelComponent binLabelComponent,
  BinFrontSurfaceComponent frontSurfaceComponent,
  BinBackSurfaceComponent backSurfaceComponent,
  BinHoleComponent holeComponent,
  BinHoleCoordinatesMetres binHoleCoordinatesMetres,
}) createBinComponents(
    {required BinType binType, required double midpointXMetres}) {
  final binHoleCoordinatesMetres =
      BinHoleCoordinatesMetres(midpointXMetres: midpointXMetres);
  return (
    binLabelComponent: BinLabelComponent(),
    frontSurfaceComponent: BinFrontSurfaceComponent(binType: binType),
    backSurfaceComponent: BinBackSurfaceComponent(binType: binType),
    holeComponent: BinHoleComponent(
        midpointXMetres: midpointXMetres,
        binHoleCoordinatesMetres: binHoleCoordinatesMetres),
    binHoleCoordinatesMetres: binHoleCoordinatesMetres,
  );
}
