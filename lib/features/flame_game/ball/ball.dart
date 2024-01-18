import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BallComponent extends CircleComponent
    with HasGameReference<EcoTossGame>, CollisionCallbacks {
  BallComponent({
    required this.radiusStart,
    required this.xVelocity,
    required this.yVelocity,
    required this.zVelocity,
  }) : super(anchor: Anchor.center);

  double radiusStart;
  double timeElapsed = 0;
  double xPosition = 0;
  double yPosition = 0;
  double zPosition = 0;

  double xVelocity;
  double yVelocity;
  double zVelocity;

  bool hasHitBackboard = false;

  @override
  Future<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("OVERLAP");
    if (zPosition >= zEnd) {
      print("COLLISION");
      hasHitBackboard = true;
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    // print(zPosition);
    timeElapsed += dt;
    xPosition =
        hasHitBackboard ? xPosition : getXPosition(timeElapsed, xVelocity);
    yPosition =
        hasHitBackboard ? yPosition : getYPosition(timeElapsed, yVelocity);
    zPosition =
        hasHitBackboard ? zPosition : getZPosition(timeElapsed, zVelocity);

    super.position = Vector2(xPosition, yPosition);
    double scaleFactor = getScaleFactor(zPosition);
    super.radius = radiusStart * scaleFactor;
    super.update(dt);
  }
}
