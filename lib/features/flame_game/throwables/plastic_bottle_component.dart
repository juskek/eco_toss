import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class PlasticBottleComponent extends ThrowableComponent {
  PlasticBottleComponent({
    super.imageFolderPath = "throwables/plastic_bottle/",
    super.spriteAnimation,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  }) {
    super.radiusStartPixels = 80;
  }
}
