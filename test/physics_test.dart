import 'package:eco_toss/features/flame_game/base_eco_toss_world.dart';
import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:test/test.dart';

void main() {
  group('Physics', () {
    test('showGameTuningUtils should be turned off', () {
      expect(showGameTuningUtils, isNot(true));
    });
    test('Wind speed should remain random', () {
      final windSpeedOne = generateRandomWindSpeed();
      final windSpeedTwo = generateRandomWindSpeed();

      expect(windSpeedOne, isNot(windSpeedTwo));
    });
  });
}
