import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class CloudComponentThree extends ParallaxComponent {
  CloudComponentThree({required this.speed});

  final double speed;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('scenery/cloud_three.png'),
    ];

    parallax = await game.loadParallax(
      layers,
      baseVelocity: Vector2(-speed, 0),
    );
  }
}
