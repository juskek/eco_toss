import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:injectable/injectable.dart';

import './i_leaderboard_repository.dart';
import './leaderboard_local_data_source.dart';
import './leaderboard_remote_data_source.dart';

@Singleton(as: ILeaderboardRepository)
class LeaderboardRepository implements ILeaderboardRepository {
  LeaderboardRepository(
      this._leaderboardLocalDataSource, this._leaderboardRemoteDataSource);

  final LeaderboardLocalDataSource _leaderboardLocalDataSource;
  final LeaderboardRemoteDataSource _leaderboardRemoteDataSource;

  @override
  Future<List<LeaderboardEntry>> get entries async {
    try {
      final entries = await _leaderboardRemoteDataSource.getEntries();
      _leaderboardLocalDataSource.entries = entries;
      return entries;
    } catch (e) {
      if (_leaderboardLocalDataSource.entries == null) {
        rethrow;
      }
      return _leaderboardLocalDataSource.entries!;
    }
  }

  @override
  Future<int?> getUserRank(String userId) async {
    try {
      final _ = await _leaderboardRemoteDataSource.getUserRank(userId);
      _leaderboardLocalDataSource.userRank = _;
      return _;
    } catch (e) {
      if (_leaderboardLocalDataSource.userRank == null) {
        rethrow;
      }
      return _leaderboardLocalDataSource.userRank!;
    }
  }
}
