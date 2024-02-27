import 'package:eco_toss/features/flame_game/utils/load_sprite_animation_from_files.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class EcoTossLogoAtom extends StatelessWidget {
  const EcoTossLogoAtom({super.key});

  Future<(SpriteAnimation animation, SpriteAnimationTicker animationTicker)>
      loadAnimation() async {
    final animation = await loadSpriteAnimationFromFilesToWidget(
        "throwables/paper_ball/", 20, 30);

    final animationTicker = SpriteAnimationTicker(animation);

    return (animation, animationTicker);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: FutureBuilder<
          (SpriteAnimation animation, SpriteAnimationTicker animationTicker)>(
        future: loadAnimation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data?.$1 != null) {
            return SpriteAnimationWidget(
              playing: true,
              animation: snapshot.data!.$1,
              animationTicker: snapshot.data!.$2,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
