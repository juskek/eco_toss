import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';

BinType getCorrectBinTypeForThrowable(ThrowableType throwableType) {
  switch (throwableType) {
    case ThrowableType.banana:
      return BinType.general;
    case ThrowableType.can:
      return BinType.metal;
    case ThrowableType.glassBottle:
      return BinType.glass;
    case ThrowableType.paperBall:
      return BinType.paper;
    case ThrowableType.plasticBottle:
      return BinType.plastic;
    default:
      throw UnimplementedError();
  }
}
