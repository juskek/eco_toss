import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class CanComponent extends ThrowableComponent {
  CanComponent({
    super.imageFolderPath = "throwables/can/",
    required super.radiusStartMetres,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  });
}
