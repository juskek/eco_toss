import 'dart:math';

/// Describes the 3D space in which the player's object is thrown.
/// Object travels into the screen from zMinMetres to zMaxMetres.
/// Floor to ceiling goes from yMinMetres to yMaxMetres.
/// Left wall to right wall goes from xMinMetres to xMaxMetres.
///
/// x is right
/// y is down
/// z is into the screen
///
/// These spatial coordinates are different from the 2D pixel coordinates
abstract class EcoToss3DSpace {
  static const xMinMetres = 0.0;
  static const xMaxMetres = 2.0;
  static double get xMidMetres => (xMaxMetres - xMinMetres) / 2;

  static const yMinMetres = 0.0;
  static const yMaxMetres = 4.0;
  static double get yMidMetres => (yMaxMetres - yMinMetres) / 2;

  static const zMinMetres = 0.0;
  static const zMaxMetres = 4.0;
  static double get zMidMetres => (zMaxMetres - zMinMetres) / 2;
}

abstract class EcoTossThrow {
  static const climbAngleDegrees = 30.0;
  static const climbAngleRadians = climbAngleDegrees * pi / 180;

  static const maxAngleDegrees = -150;
  static const minAngleDegrees = -30;
  static const maxAngleRadians = maxAngleDegrees * pi / 180;
  static const minAngleRadians = minAngleDegrees * pi / 180;

  static const noThrowAngleDegrees = 180;
  static const noThrowAngleRadians = noThrowAngleDegrees * pi / 180;

  static const airResistanceVelocityMultiplier = 0.03;

  static const windCoefficientVelocityMultiplier = 2;

  static const bounceEnergyXVelocityMultiplier = 0.5;
  static const bounceEnergyYVelocityMultiplier = 0.5;
  static const bounceEnergyZVelocityMultiplier = 0.3;

  static const velocityMps = 7.0;
  static const zVelocityMps = 8.5;
}

const scaleStart = 3.0;
const scaleEnd = 1.0;

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

double generateRandomWindSpeed() {
  /// Scales to [0, maxWindSpeed) then shift to [-maxWindSpeed, maxWindSpeed)
  double minMaxWindSpeed = 3.5;
  return Random().nextDouble() * minMaxWindSpeed * 2 - minMaxWindSpeed;
  // return minMaxWindSpeed;
}
