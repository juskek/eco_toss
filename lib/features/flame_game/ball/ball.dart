import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BallComponent extends CircleComponent
    with HasGameReference<EcoTossGame>, CollisionCallbacks {
  BallComponent({
    required this.radiusStart,
    required this.xPosition,
    required this.yPosition,
    required this.zPosition,
  }) : super(anchor: Anchor.center);

  double radiusStart;
  double timeElapsed = 0;
  double xPosition;
  double yPosition;
  double zPosition;

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
    xPosition = hasHitBackboard ? xPosition : getXPosition(timeElapsed, 0);
    yPosition = hasHitBackboard ? yPosition : getYPosition(timeElapsed, -50);
    zPosition = hasHitBackboard ? zPosition : getZPosition(timeElapsed, 25);

    super.position = Vector2(xPosition, yPosition);
    double scaleFactor = getScaleFactor(zPosition);
    super.radius = radiusStart * scaleFactor;
    super.update(dt);
  }
}
