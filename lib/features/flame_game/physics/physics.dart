// ignore_for_file: constant_identifier_names

import 'dart:math';

const X_START = 1;
const Y_START = 1;
const Z_START = 1;
const Z_END = 250;
const Y_FLOOR = -50;

const SCALE_START = 1;
const SCALE_END = 0.1;

const GRAVITY = 9.81;

const SCALE_RATE = (SCALE_START - SCALE_END) / (Z_END - Z_START);

double getScaleFactor(double zCurrent) {
  return SCALE_START - (SCALE_RATE * (zCurrent - Z_START));
}

double getXPosition(double timeElapsed, double xVelocity) {
  return X_START + xVelocity * timeElapsed;
}

double getYPosition(double timeElapsed, double yVelocity) {
  return Y_START +
      (yVelocity * timeElapsed) +
      (0.5 * GRAVITY * pow(timeElapsed, 2));
}

double getZPosition(double timeElapsed, double zVelocity) {
  return Z_START + zVelocity * timeElapsed;
}
