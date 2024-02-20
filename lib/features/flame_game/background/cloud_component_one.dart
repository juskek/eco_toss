import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class CloudComponentOne extends ParallaxComponent {
  CloudComponentOne({required this.speed});

  final double speed;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('scenery/cloud_one.png'),
    ];

    parallax = await game.loadParallax(
      layers,
      baseVelocity: Vector2(-speed, 0),
      repeat: ImageRepeat.repeatX,
    );
  }
}
