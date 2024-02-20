import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/bin/bin_dimensions.dart';
import 'package:eco_toss/features/flame_game/eco_toss_camera_component.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class BaseEcoTossGame extends FlameGame<BaseEcoTossWorld> {
  BaseEcoTossGame({super.world})
      : super(
          camera: EcoTossCameraComponent(),
        );

  double windSpeedMps = 0;
  Component? cloudComponent;

  final scoreNotifier = ValueNotifier(0);

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  void onMiss();

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.position = Vector2(0, 0);

    EcoTossPositioning.setCanvasSize(canvasSize.y, canvasSize.x);

    const scoreText = 'Recycled: 0';

    final textXYZMetres = Vector3(
        EcoToss3DSpace.xMidMetres,
        EcoToss3DSpace.yMinMetres + BinDimensions.heightMetres + 0.2,
        EcoToss3DSpace.zMaxMetres);

    final textXYPixels = EcoTossPositioning.xyzMetresToXyPixels(textXYZMetres);

    // Can't seem to set the origin of the viewport to be the centre of the screen, so this is a workaround
    final viewportOrigin = Vector2(
      canvasSize.x / 2,
      canvasSize.y / 2,
    );

    final scoreComponent = TextComponent(
      text: scoreText,
      position: Vector2(
          viewportOrigin.x + textXYPixels.x, viewportOrigin.y + textXYPixels.y),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'Happy Monkey',
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );

    camera.viewport.add((scoreComponent));

    scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${scoreNotifier.value}');
    });
  }
}
