import 'package:flame/components.dart';
import 'package:flame/game.dart';

Future<SpriteAnimation> loadSpriteAnimationFromFiles(
    Game game, String folderPath, int numberOfFiles) async {
  List<Sprite> sprites = [];

  for (int i = 1; i <= numberOfFiles; i++) {
    String frameNumber = i.toString().padLeft(4, '0');
    Sprite sprite = await game.loadSprite(
      '$folderPath$frameNumber.png',
      srcSize: Vector2.all(1080),
      srcPosition: Vector2(0, 0),
    );
    sprites.add(sprite);
  }

  return SpriteAnimation.spriteList(
    sprites,
    stepTime: 0.01,
  );
}
