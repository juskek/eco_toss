import 'dart:math';

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

    final baseVelocity = Vector2(speed / pow(2, layers.length), 0);

    final velocityMultiplierDelta = Vector2(2.0, 0.0);

    parallax = await game.loadParallax(
      layers,
      baseVelocity: baseVelocity,
      velocityMultiplierDelta: velocityMultiplierDelta,
    );
  }
}
