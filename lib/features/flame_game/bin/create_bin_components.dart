import 'package:eco_toss/features/flame_game/bin/bin_back_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_front_surface_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_component.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/bin/bin_label/bin_label_component.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';

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

  final frontSurfaceComponent = BinFrontSurfaceComponent(binType: binType);
  final binLabelComponent = BinLabelComponent(
      binType: binType,
      midpointXMetres: midpointXMetres,
      frontSurfaceTopEdgeXyPixels: frontSurfaceComponent.topEdgeXyPixels);
  return (
    binLabelComponent: binLabelComponent,
    frontSurfaceComponent: frontSurfaceComponent,
    backSurfaceComponent: BinBackSurfaceComponent(binType: binType),
    holeComponent: BinHoleComponent(
        midpointXMetres: midpointXMetres,
        binHoleCoordinatesMetres: binHoleCoordinatesMetres),
    binHoleCoordinatesMetres: binHoleCoordinatesMetres,
  );
}
