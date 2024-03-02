import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class BananaComponent extends ThrowableComponent {
  BananaComponent({
    super.imageFolderPath = "throwables/banana/",
    super.spriteAnimation,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  }) {
    super.radiusStartPixels = 80;
  }
}
