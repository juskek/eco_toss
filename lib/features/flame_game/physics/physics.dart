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

double getXPosition(double timeElapsed, double xVelocity) {
  return xStart + xVelocity * timeElapsed;
}

double getYPosition(double timeElapsed, double yVelocity) {
  return yStart +
      (yVelocity * timeElapsed) +
      (0.5 * gravity * pow(timeElapsed, 2));
}

double getZPosition(double timeElapsed, double zVelocity) {
  return zStart + zVelocity * timeElapsed;
}
