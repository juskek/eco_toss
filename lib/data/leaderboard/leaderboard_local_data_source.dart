import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:injectable/injectable.dart';

@singleton
class LeaderboardLocalDataSource {
  static const String hiveBoxName = 'LeaderboardLocalDataSource';
  List<LeaderboardEntry>? entries;
  int? userRank;
}
