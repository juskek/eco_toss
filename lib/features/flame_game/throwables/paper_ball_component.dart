import 'package:eco_toss/features/flame_game/throwables/throwable_component.dart';

class PaperBallComponent extends ThrowableComponent {
  PaperBallComponent({
    super.imageFolderPath = "throwables/paper_ball/",
    required super.radiusStartMetres,
    required super.onMiss,
    required super.onBinned,
    required super.binHoleCoordinatesMetres,
    required super.windSpeedMps2,
  });
}
