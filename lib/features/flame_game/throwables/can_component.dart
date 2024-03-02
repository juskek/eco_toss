import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class CanComponent extends ThrowableComponent {
  CanComponent({
    super.imageFolderPath = "throwables/can/",
    super.spriteAnimation,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  }) {
    super.radiusStartPixels = 60;
  }
}
