import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/flame_game/utils/load_sprite_animation_from_files.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

@injectable
class SpriteViewModel extends ChangeNotifier {
  SpriteViewModel();

  SpriteAnimation? _paperBallSprite;
  SpriteAnimation? _bananaSprite;
  SpriteAnimation? _glassBottleSprite;
  SpriteAnimation? _plasticBottleSprite;
  SpriteAnimation? _canSprite;

  SpriteAnimation get paperBallSprite => _paperBallSprite!;
  SpriteAnimation? get bananaSprite => _bananaSprite;
  SpriteAnimation? get glassBottleSprite => _glassBottleSprite;
  SpriteAnimation? get plasticBottleSprite => _plasticBottleSprite;
  SpriteAnimation? get canSprite => _canSprite;

  Future<void> loadSpriteAnimationsToGame(Game game) async {
    _paperBallSprite = await loadSpriteAnimationFromFilesToGame(
        game, "throwables/paper_ball/", 48);

    loadSpriteAnimationFromFilesToGame(game, "throwables/banana/", 48)
        .then((value) {
      _bananaSprite = value;
    });
    loadSpriteAnimationFromFilesToGame(game, "throwables/glass_bottle/", 48)
        .then((value) {
      _glassBottleSprite = value;
    });
    loadSpriteAnimationFromFilesToGame(game, "throwables/plastic_bottle/", 48)
        .then((value) {
      _plasticBottleSprite = value;
    });
    loadSpriteAnimationFromFilesToGame(game, "throwables/can/", 48)
        .then((value) {
      _canSprite = value;
    });
  }
}
