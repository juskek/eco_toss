import 'package:eco_toss/features/flame_game/eco_toss_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<EcoTossGame>(
        key: const Key('tutorial'),
        game: EcoTossGame(),
      ),
    );
  }
}
