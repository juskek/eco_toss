import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class ScoreLocalDataSource {
  static const String hiveBoxName = 'ScoreLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  Future<int?> get highScore async {
    // await box.put('highScore', 0);
    final highScore = (await box.get('highScore')) as int?;
    return highScore;
  }

  Future<void> setHighScore(int _) async {
    await box.put('highScore', _);
  }
}
