import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class PlasticBottleComponent extends ThrowableComponent {
  PlasticBottleComponent({
    super.imageFolderPath = "throwables/plastic_bottle/",
    required super.radiusStartMetres,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  });
}
