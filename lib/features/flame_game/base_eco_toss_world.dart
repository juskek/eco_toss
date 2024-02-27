import 'package:eco_toss/features/flame_game/utils/floor_far_edge.dart';
import 'package:eco_toss/features/flame_game/utils/show_xyz_dimensions.dart';
import 'package:flame/components.dart';

const bool showGameTuningUtils = false;

abstract class BaseEcoTossWorld extends World
    with HasCollisionDetection, HasGameRef {
  @override
  Future<void> onLoad() async {
    if (showGameTuningUtils) {
      add(FloorFarEdge());
      showXYZDimensions(this);
    }
  }
}
