import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class ScoreLocalDataSource {
  static const String hiveBoxName = 'ScoreLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  Future<int?> get highScore async {
    final highScore = (await box.get('highScore')) as int?;
    return highScore;
  }
}
