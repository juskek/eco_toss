import 'dart:math';

import 'package:flame/components.dart';

class EcoTossWorld extends World {
  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      position: Vector2(200, 50),
      size: Vector2.all(30),
      angle: pi / 4,
      anchor: Anchor.center,
    ));
  }
}
