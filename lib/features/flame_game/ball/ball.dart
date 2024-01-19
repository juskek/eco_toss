import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class BallComponent extends CircleComponent
    with HasGameReference<EcoTossGame>, CollisionCallbacks, DragCallbacks {
  BallComponent({
    required this.radiusStart,
    required this.xPosition,
    required this.yPosition,
    required this.zPosition,
  }) : super(anchor: Anchor.center);

  double radiusStart;
  double timeSinceThrow = 0;
  double xPosition;
  double yPosition;
  double zPosition;

  bool hasHitBackboard = false;

  bool isThrown = false;
  double xThrowVelocity = 0;
  double yThrowVelocity = 0;

  @override
  void onDragEnd(DragEndEvent event) {
    isThrown = true;
    xThrowVelocity = event.velocity[0];
    yThrowVelocity = event.velocity[1];
    print(event);
  }

  @override
  Future<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (zPosition >= Z_END) {
      print("COLLISION");
      hasHitBackboard = true;
    }

    super.onCollision(points, other);
  }

  @override
  void update(double dt) {
    // print(zPosition);
    if (isThrown) {
      timeSinceThrow += dt;
      xPosition = hasHitBackboard
          ? xPosition
          : getXPosition(timeSinceThrow, xThrowVelocity);
      yPosition = hasHitBackboard
          ? yPosition
          : getYPosition(timeSinceThrow, yThrowVelocity);
      zPosition =
          hasHitBackboard ? zPosition : getZPosition(timeSinceThrow, 25);
    }

    double scaleFactor = getScaleFactor(zPosition);
    super.position = Vector2(xPosition, yPosition);
    super.radius = radiusStart * scaleFactor;
    super.update(dt);
  }
}
