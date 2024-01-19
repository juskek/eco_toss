// x is right
// y is down
// z is into the screen

import 'dart:math';

const throwingVelocityScale = 0.1;

const climbAngleDegrees = 45.0;
const climbAngleRadians = climbAngleDegrees * pi / 180;

const coneAngleDegrees = 120.0;
const coneAngleRadians = coneAngleDegrees * pi / 180;

const zStartMetres = 1;
const zBinStartMetres = 200;
const zEndMetres = 250;
const yFloorPixels = 250.0;

const scaleStart = 1;
const scaleEnd = 0.1;

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
