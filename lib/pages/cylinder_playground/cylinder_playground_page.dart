import 'package:endless_runner/features/cylinder/cylinder_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CylinderPlaygroundPage extends StatelessWidget {
  const CylinderPlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<CylinderGame>(
        key: const Key('play session'),
        game: CylinderGame(),
      ),
    );
  }
}
