List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.score:
      return const [
        'complete_task.mp3',
      ];
    case SfxType.toss:
      return const [
        'swing.mp3',
        'swing2.mp3',
        'swing3.mp3',
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
      return 2.7;
    case SfxType.toss:
      return 2;
    case SfxType.buttonTap:
      return 1.0;
  }
}

enum SfxType {
  score,
  toss,
  buttonTap,
}
