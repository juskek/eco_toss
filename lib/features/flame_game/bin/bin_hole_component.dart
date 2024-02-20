import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/bin/bin_hole_coordinates.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BinHoleComponent extends PolygonComponent {
  BinHoleComponent._(super._vertices) {
    priority = 1;
  }
  factory BinHoleComponent({
    required double midpointXMetres,
    required BinHoleCoordinatesMetres binHoleCoordinatesMetres,
  }) {
    final backLeftCornerPixels = EcoTossPositioning.xyzMetresToXyPixels(
        binHoleCoordinatesMetres.backLeftCornerMetres);
    final backRightCornerPixels = EcoTossPositioning.xyzMetresToXyPixels(
        binHoleCoordinatesMetres.backRightCornerMetres);
    final frontLeftCornerPixels = EcoTossPositioning.xyzMetresToXyPixels(
        binHoleCoordinatesMetres.frontLeftCornerMetres);
    final frontRightCornerPixels = EcoTossPositioning.xyzMetresToXyPixels(
        binHoleCoordinatesMetres.frontRightCornerMetres);

    final sizeScale = getScaleFactor(BinDimensions.frontSurfaceZMetres);

    final frontLengthPixels =
        EcoTossPositioning.xSizeMetresToPixels(BinDimensions.widthMetres);
    final frontScaledLengthPixels = frontLengthPixels * sizeScale;

    final frontHeightPixels =
        EcoTossPositioning.ySizeMetresToPixels(BinDimensions.heightMetres);
    final frontScaledHeightPixels = frontHeightPixels * sizeScale;
    final frontScaledHeightDifferencePixels =
        frontScaledHeightPixels - frontHeightPixels;

    final midpointPixels = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
        midpointXMetres,
        BinDimensions.heightMetres,
        BinDimensions.frontSurfaceZMetres));

    final frontLeftCornerScaledPixels = Vector2(
        midpointPixels.x - frontScaledLengthPixels / 2,
        frontLeftCornerPixels.y - frontScaledHeightDifferencePixels);
    final frontRightCornerScaledPixels = Vector2(
        midpointPixels.x + frontScaledLengthPixels / 2,
        frontRightCornerPixels.y - frontScaledHeightDifferencePixels);

    List<Vector2> vertices = [
      backLeftCornerPixels,
      backRightCornerPixels,
      frontRightCornerScaledPixels,
      frontLeftCornerScaledPixels,
    ];
    return BinHoleComponent._(vertices);
  }

  @override
  void onLoad() async {
    super.paint = (Paint()
      ..color = Colors.white.withOpacity(showGameTuningUtils ? 0.5 : 0));
  }
}
