import 'package:eco_toss/features/flame_game/physics/physics.dart';
import 'package:test/test.dart';

void main() {
  group('Physics', () {
    test('Wind speed should remain random', () {
      final windSpeedOne = generateRandomWindSpeed();
      final windSpeedTwo = generateRandomWindSpeed();

      expect(windSpeedOne, isNot(windSpeedTwo));
    });
  });
}
