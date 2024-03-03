import 'package:eco_toss/features/flame_game/game_implementations/main/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Utils', () {
    test("Wind speed 0 should show as '0'", () {
      const windSpeedMps2 = 0;
      final windSpeedMps2String =
          windSpeedDoubleToPrettyString(windSpeedMps2.toDouble());

      expect(windSpeedMps2String, '0');
    });
    test("Wind speed 0.0x should show as '0'", () {
      const windSpeedMps2 = 0.01;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '0');
    });
    test("Wind speed -0.0x should show as '0'", () {
      const windSpeedMps2 = -0.01;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '0');
    });
    test("Wind speed 1.52 should show as '1.5'", () {
      const windSpeedMps2 = 1.52;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '1.5');
    });
    test("Wind speed -1.52 should show as '-1.5'", () {
      const windSpeedMps2 = -1.52;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '-1.5');
    });
    test("Wind speed 1.55 should show as '1.6'", () {
      const windSpeedMps2 = 1.55;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '1.6');
    });
    test("Wind speed -1.55 should show as '-1.6'", () {
      const windSpeedMps2 = -1.55;
      final windSpeedMps2String = windSpeedDoubleToPrettyString(windSpeedMps2);

      expect(windSpeedMps2String, '-1.6');
    });
  });
}
