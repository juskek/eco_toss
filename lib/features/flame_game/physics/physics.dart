// x is right
// y is down
// z is into the screen

import 'dart:math';

/// Used to scale the velocity of the ball when it is thrown.
/// e.g. velocity in m/s = pixels per second / pixels per metre
/// Also used to scale dimensions of objects on screen
/// e.g. size in pixels = size in metres * pixels per metre
const pixelsPerMetre = 300;

const climbAngleDegrees = 45.0;
const climbAngleRadians = climbAngleDegrees * pi / 180;

const coneAngleDegrees = 120.0;
const coneAngleRadians = coneAngleDegrees * pi / 180;

const zStartMetres = 1;
const zEndMetres = 5.0;
const zBinDepth = 0.3;
const zBinStartMetres = zEndMetres - zBinDepth;

const yFloorMetres = 1.0;
const yFloorPixels = yFloorMetres * pixelsPerMetre;

const scaleStart = 1;
const scaleEnd = 0.5;

const gravityMps2 = 9.81;

const scaleRate = (scaleStart - scaleEnd) / (zEndMetres - zStartMetres);

double getScaleFactor(double zCurrent) {
  return scaleStart - (scaleRate * (zCurrent - zStartMetres));
}

double getDistanceTravelled(double timeSeconds, double velocityMps) {
  return velocityMps * timeSeconds;
}

double applyGravityToYVelocity(double timeSeconds, double yVelocityMps) {
  return yVelocityMps + (gravityMps2 * timeSeconds);
}
