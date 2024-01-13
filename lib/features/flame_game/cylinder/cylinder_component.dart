import 'package:endless_runner/features/flame_game/cylinder/cylinder_painter.dart';
import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:flame/components.dart';

class CylinderComponent extends CustomPainterComponent
    with HasGameReference<EcoTossGame> {
  CylinderComponent({
    required this.rotationX,
    required this.rotationY,
    required this.rotationZ,
  });
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  static const speed = 150;

  int direction = 1;

  @override
  Future<void> onLoad() async {
    size = Vector2.all(50);

    // y = 0;
  }

  @override
  void update(double dt) {
    painter = CylinderCustomPainter(
        rotationX: rotationX, rotationY: rotationY, rotationZ: rotationZ);

    x += speed * direction * dt;

    if ((x + width >= game.size.x && direction > 0) ||
        (x <= 0 && direction < 0)) {
      direction *= -1;
    }
    super.update(dt);
  }
}
