import 'package:endless_runner/features/flame_game/cylinder/cylinder_painter.dart';
import 'package:endless_runner/features/flame_game/eco_toss_game.dart';
import 'package:flame/components.dart';

class CylinderComponent extends CustomPainterComponent
    with HasGameReference<EcoTossGame> {
  static const speed = 150;

  int direction = 1;

  @override
  Future<void> onLoad() async {
    painter = CylinderCustomPainter();

    size = Vector2.all(100);

    // y = 0;
  }

  @override
  void update(double dt) {
    super.update(dt);

    x += speed * direction * dt;

    if ((x + width >= game.size.x && direction > 0) ||
        (x <= 0 && direction < 0)) {
      direction *= -1;
    }
  }
}
