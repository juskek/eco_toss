import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class GlassBottleComponent extends ThrowableComponent {
  GlassBottleComponent({
    super.imageFolderPath = "throwables/glass_bottle/",
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  }) {
    super.radiusStartPixels = 80;
  }
}
