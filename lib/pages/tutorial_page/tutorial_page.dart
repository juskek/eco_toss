import 'package:eco_toss/features/flame_game/base_eco_toss_game.dart';
import 'package:eco_toss/features/flame_game/game_implementations/tutorial_eco_toss_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<BaseEcoTossGame>(
        key: const Key('tutorial'),
        game: TutorialEcoTossGame(),
      ),
    );
  }
}
