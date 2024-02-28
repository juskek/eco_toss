import 'package:eco_toss/atomic/atoms/color_atom.dart';
import 'package:eco_toss/features/audio/audio_controller.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class CycleBinsButtonComponent extends ButtonComponent {
  CycleBinsButtonComponent(
    this.gameViewModel, {
    required this.audioController,
  }) : super(
          anchor: Anchor.center,
        );

  final GameViewModel gameViewModel;
  final AudioController audioController;

  @override
  void onLoad() {
    final game = findGame()!;
    position = Vector2(game.size.x / 2, game.size.y - 80);

    const fontSize = 30.0;
    size = Vector2(game.size.x, fontSize * 1.1);

    button = TextComponent(
      text: 'Cycle Bins',
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'Happy Monkey',
          fontSize: fontSize,
          color: ColorAtom.almostWhite,
        ),
      ),
    );
    super.onLoad();
  }

  @override
  void onTapUp(event) {
    gameViewModel.cycleBins();
    // audioController.playSound('cycle_bins');
    return super.onTapUp(event);
  }
}
