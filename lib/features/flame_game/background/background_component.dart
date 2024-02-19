import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class BackgroundComponent extends ParallaxComponent {
  BackgroundComponent();

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('scenery/eco_toss_background.png'),
    ];

    y = -50;

    parallax = await game.loadParallax(
      layers,
    );
  }
}
