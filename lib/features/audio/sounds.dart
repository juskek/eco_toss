List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.score:
      return const [
        'score1.mp3',
        'score2.mp3',
      ];
    case SfxType.toss:
      return const [
        'score1.mp3',
        'score2.mp3',
      ];
    case SfxType.jump:
      return const [
        'jump1.mp3',
      ];
    case SfxType.doubleJump:
      return const [
        'double_jump1.mp3',
      ];
    case SfxType.hit:
      return const [
        'hit1.mp3',
        'hit2.mp3',
      ];
    case SfxType.damage:
      return const [
        'damage1.mp3',
        'damage2.mp3',
      ];

    case SfxType.buttonTap:
      return const [
        'zipclick.mp3',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.score:
    case SfxType.toss:
    case SfxType.jump:
    case SfxType.doubleJump:
    case SfxType.damage:
    case SfxType.hit:
      return 0.4;
    case SfxType.buttonTap:
      return 1.0;
  }
}

enum SfxType {
  score,
  toss,

  @Deprecated('legacy from endless runner')
  jump,
  @Deprecated('legacy from endless runner')
  doubleJump,
  @Deprecated('legacy from endless runner')
  hit,
  @Deprecated('legacy from endless runner')
  damage,
  buttonTap,
}
