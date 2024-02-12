import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class ScoreLocalDataSource {
  final box = Hive.box('ScoreLocalDataSource');

  int? get highScore {
    return box.get('highScore') as int?;
  }
}
