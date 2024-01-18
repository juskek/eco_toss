import 'dart:math';

const xStart = 1;
const yStart = 1;
const zStart = 1;
const zEnd = 250;
const yFloor = -50;

const scaleStart = 1;
const scaleEnd = 0.1;

const gravity = 9.81;

const scaleRate = (scaleStart - scaleEnd) / (zEnd - zStart);

double getScaleFactor(double zCurrent) {
  return scaleStart - (scaleRate * (zCurrent - zStart));
}

@Deprecated(
    'use getDistanceTravelled instead, so that an objects velocity can change after it has been thrown e.g. with wind')
double getXPosition(double timeElapsed, double xInitialVelocity) {
  return xStart + xInitialVelocity * timeElapsed;
}

@Deprecated(
    'use getDistanceTravelled instead, so that an objects velocity can change after it has been thrown e.g. with wind')
double getYPosition(double timeElapsed, double yInitialVelocity) {
  return yStart +
      (yInitialVelocity * timeElapsed) +
      (0.5 * gravity * pow(timeElapsed, 2));
}

@Deprecated(
    'use getDistanceTravelled instead, so that an objects velocity can change after it has been thrown e.g. with wind')
double getZPosition(double timeElapsed, double zInitialVelocity) {
  return zStart + zInitialVelocity * timeElapsed;
}

double getDistanceTravelled(double time, double velocity) {
  return velocity * time;
}

double applyGravityToYVelocity(double time, double yVelocity) {
  return yVelocity + (gravity * time);
}
