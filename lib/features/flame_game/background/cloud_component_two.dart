import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class CloudComponentTwo extends ParallaxComponent {
  CloudComponentTwo({required this.speed});

  final double speed;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('scenery/cloud_two.png'),
    ];

    parallax = await game.loadParallax(
      layers,
      baseVelocity: Vector2(-speed, 0),
    );
  }
}
