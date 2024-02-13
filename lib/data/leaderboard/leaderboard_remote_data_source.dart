import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:injectable/injectable.dart';

@singleton
class LeaderboardRemoteDataSource {
  CollectionReference leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');

  Future<List<LeaderboardEntry>> getEntries() async {
    final querySnapshot = await leaderboard.orderBy({"score"}).limit(10).get();
    List<LeaderboardEntry> leaderboardEntries = [];
    for (var element in querySnapshot.docs) {
      final json = element.data() as Map<String, dynamic>;
      final entry = LeaderboardEntry.fromJson(json);
      leaderboardEntries.add(entry);
    }
    return leaderboardEntries;
  }

  Future<int> getUserRank(String userId) async {
    print('getUserRank: $userId');
    final querySnapshot = await leaderboard
        .orderBy({"score"})
        .where("userId", isEqualTo: userId)
        .limit(1)
        .get();
    print('getUserRank: ${querySnapshot.docs.first.data()} ');
    final json = querySnapshot.docs.first.data() as Map<String, dynamic>;
    final entry = LeaderboardEntry.fromJson(json);
    print('getUserRank: ${entry.score} ');
    return entry.score;
  }
}
