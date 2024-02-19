import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:flame/components.dart';

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
