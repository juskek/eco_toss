import 'dart:math';

import 'package:eco_toss/features/flame_game/game_implementations/main/game_view_model.dart';

bool isThrowableInCorrectBin(BinType binType, ThrowableType throwableType) {
  if (binType == BinType.general) {
    if (throwableType == ThrowableType.banana) {
      return true;
    }
  }
  if (binType == BinType.glass) {
    if (throwableType == ThrowableType.glassBottle) {
      return true;
    }
  }

  if (binType == BinType.paper) {
    if (throwableType == ThrowableType.paperBall) {
      return true;
    }
  }

  if (binType == BinType.plastic) {
    if (throwableType == ThrowableType.plasticBottle) {
      return true;
    }
  }

  if (binType == BinType.metal) {
    if (throwableType == ThrowableType.can) {
      return true;
    }
  }

  return false;
}

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

BinType getAnotherRandomBinType(BinType binType) {
  List<BinType> binTypes = List<BinType>.from(BinType.values);
  binTypes.remove(binType);
  return binTypes[Random().nextInt(binTypes.length)];
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
