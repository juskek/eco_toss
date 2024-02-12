import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';

abstract class ILeaderboardRepository {
  List<LeaderboardEntry> get entries;
}
