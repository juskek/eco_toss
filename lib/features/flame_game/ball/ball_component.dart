import 'package:eco_toss/features/flame_game/ball/throwable_component.dart';

class BallComponent extends ThrowableComponent {
  BallComponent({
    super.imageFolderPath = "throwables/paper_ball/",
    required super.radiusStartMetres,
    required super.onMiss,
    required super.addScore,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  });
}
