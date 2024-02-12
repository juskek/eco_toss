import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class LeaderboardLocalDataSource {
  final box = Hive.box('LeaderboardLocalDataSource');
  List<LeaderboardEntry>? entries;
  int? userRank;
}
