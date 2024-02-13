import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';

abstract class ILeaderboardRepository {
  Future<List<LeaderboardEntry>> get entries;

  Future<int?> getUserRank(String userId);
}
