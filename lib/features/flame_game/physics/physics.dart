// x is right
// y is down
// z is into the screen

const zStart = 1;
const zEnd = 250;
const yFloor = 250.0;

const scaleStart = 1;
const scaleEnd = 0.1;

const gravity = 9.81;

const scaleRate = (scaleStart - scaleEnd) / (zEnd - zStart);

double getScaleFactor(double zCurrent) {
  return scaleStart - (scaleRate * (zCurrent - zStart));
}

double getDistanceTravelled(double time, double velocity) {
  return velocity * time;
}

double applyGravityToYVelocity(double time, double yVelocity) {
  return yVelocity + (gravity * time);
}
