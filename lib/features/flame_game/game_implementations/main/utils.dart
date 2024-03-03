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

String windSpeedDoubleToPrettyString(double windSpeedMps2) {
  if (windSpeedMps2 == 0) {
    return '0';
  }
  final windSpeedMps2String = windSpeedMps2.toStringAsFixed(1);
  if (windSpeedMps2String.contains('0.0')) {
    return '0';
  }
  return windSpeedMps2String;
}
