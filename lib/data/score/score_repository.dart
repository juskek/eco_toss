import 'package:injectable/injectable.dart';

import './i_score_repository.dart';
import './score_local_data_source.dart';
import './score_remote_data_source.dart';

@Singleton(as: IScoreRepository)
class ScoreRepository implements IScoreRepository {
  ScoreRepository(this._scoreLocalDataSource, this._scoreRemoteDataSource);

  final ScoreLocalDataSource _scoreLocalDataSource;
  final ScoreRemoteDataSource _scoreRemoteDataSource;

  @override
  Future<int?> get highScore async {
    return await _scoreLocalDataSource.highScore;
  }

  @override
  Future<void> setHighScore(int _) async {
    await _scoreLocalDataSource.setHighScore(_);
  }
}
