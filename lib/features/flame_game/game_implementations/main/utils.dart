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
