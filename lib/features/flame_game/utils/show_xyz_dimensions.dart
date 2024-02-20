import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:eco_toss/features/flame_game/positioning/positioning.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void showXYZDimensions(World world) {
  for (var xMetres = EcoToss3DSpace.xMinMetres;
      xMetres <= EcoToss3DSpace.xMaxMetres;
      xMetres += 0.5) {
    final xPixels = EcoTossPositioning.xyzMetresToXyPixels(
            Vector3(xMetres, EcoToss3DSpace.yMidMetres, 0))
        .x;

    world.add(
      TextComponent(
        text: 'x: ${xMetres.toStringAsFixed(1)}m, ${xPixels.toInt()}px',
        position: Vector2(xPixels, 0),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  for (var yMetres = EcoToss3DSpace.yMinMetres;
      yMetres <= EcoToss3DSpace.yMaxMetres;
      yMetres += 0.5) {
    final yPixels = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
            EcoToss3DSpace.xMinMetres, yMetres, EcoToss3DSpace.zMinMetres))
        .y;
    world.add(
      TextComponent(
        text: 'y: ${yMetres.toStringAsFixed(1)}m, ${yPixels.toInt()}px',
        position: Vector2(EcoTossPositioning.leftX, yPixels),
        anchor: Anchor.bottomLeft,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  for (var zMetres = EcoToss3DSpace.zMinMetres;
      zMetres <= EcoToss3DSpace.zMaxMetres;
      zMetres += 0.5) {
    final zPixels = EcoTossPositioning.xyzMetresToXyPixels(Vector3(
            EcoToss3DSpace.xMaxMetres, EcoToss3DSpace.yMinMetres, zMetres))
        .y;

    world.add(
      TextComponent(
        text: 'zMetres: ${zMetres.toStringAsFixed(1)}m, ${zPixels.toInt()}px',
        position: Vector2(EcoTossPositioning.rightX, zPixels),
        anchor: Anchor.bottomRight,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
