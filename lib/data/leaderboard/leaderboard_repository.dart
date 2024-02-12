import 'package:injectable/injectable.dart';
import './i_leaderboard_repository.dart';
import './leaderboard_local_data_source.dart';
import './leaderboard_remote_data_source.dart';

@Singleton(as: ILeaderboardRepository)
class LeaderboardRepository implements ILeaderboardRepository {
  LeaderboardRepository(this._leaderboardLocalDataSource,this._leaderboardRemoteDataSource);

  final LeaderboardLocalDataSource _leaderboardLocalDataSource;
  final LeaderboardRemoteDataSource _leaderboardRemoteDataSource;

}