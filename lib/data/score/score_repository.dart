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
  int? get highScore {
    return _scoreLocalDataSource.highScore;
  }
}
