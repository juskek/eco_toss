// x is right
// y is down
// z is into the screen

import 'dart:math';

/// Used to scale the velocity of the ball when it is thrown.
/// e.g. velocity in m/s = pixels per second / pixels per metre
/// Also used to scale dimensions of objects on screen
/// e.g. size in pixels = size in metres * pixels per metre

/// Describes the 3D space in which the player's object is thrown.
/// Object travels into the screen from zMinMetres to zMaxMetres.
/// Floor to ceiling goes from yMinMetres to yMaxMetres.
/// Left wall to right wall goes from xMinMetres to xMaxMetres.
///
/// These spatial coordinates are different from the 2D pixel coordinates
abstract class EcoToss3DSpace {
  static const xMinMetres = 0.0;
  static const xMaxMetres = 2.0;
  static double get xMidMetres => (xMaxMetres - xMinMetres) / 2;

  static const yMinMetres = 0.0;
  static const yMaxMetres = 5.0;
  static double get yMidMetres => (yMaxMetres - yMinMetres) / 2;

  static const zMinMetres = 0.0;
  static const zMaxMetres = 5.0;
  static double get zMidMetres => (zMaxMetres - zMinMetres) / 2;
}

abstract class EcoTossThrow {
  static const climbAngleDegrees = 30.0;
  static const climbAngleRadians = climbAngleDegrees * pi / 180;

  static const coneAngleDegrees = 120.0;
  static const coneAngleRadians = coneAngleDegrees * pi / 180;

  static const powerScale = 0.5;
}

const scaleStart = 1;
const scaleEnd = 0.5;

const gravityMps2 = 9.81;

const scaleRate = (scaleStart - scaleEnd) /
    (EcoToss3DSpace.zMaxMetres - EcoToss3DSpace.zMinMetres);

double getScaleFactor(double zPositionMetres) {
  return scaleStart -
      (scaleRate * (zPositionMetres - EcoToss3DSpace.zMinMetres));
}

double getDistanceTravelled(double timeSeconds, double velocityMps) {
  return velocityMps * timeSeconds;
}

double applyGravityToYVelocity(double timeSeconds, double yVelocityMps) {
  return yVelocityMps - (gravityMps2 * timeSeconds);
}

// double getYPixelPositionFromDepth(
//     double screenHeightPixels, double zPositionMetres) {
//   final yPixelsPerZMetre =
//       screenHeightPixels * 0.9 / (zStartMetres - zEndMetres).abs();
//   return zPositionMetres * yPixelsPerZMetre;
// }
