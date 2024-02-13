import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class ScoreLocalDataSource {
  static const String hiveBoxName = 'ScoreLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  int? get highScore {
    return box.get('highScore') as int?;
  }
}
