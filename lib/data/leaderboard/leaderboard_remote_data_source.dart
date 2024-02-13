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
    final querySnapshot = await leaderboard.orderBy("score").limit(10).get();

    // iterate through the querySnapshot.docs to find the user's rank
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      final json = querySnapshot.docs[i].data() as Map<String, dynamic>;
      final entry = LeaderboardEntry.fromJson(json);
      if (entry.userId == userId) {
        return i + 1;
      }
    }
    return -1;
  }
}
