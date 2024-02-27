import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class GlassBottleComponent extends ThrowableComponent {
  GlassBottleComponent({
    super.imageFolderPath = "throwables/glass_bottle/",
    required super.radiusStartMetres,
    required super.onMiss,
    required super.addScore,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  });
}
