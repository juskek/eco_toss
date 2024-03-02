import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:injectable/injectable.dart';

@singleton
class LeaderboardRemoteDataSource {
  CollectionReference leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');

  Future<List<LeaderboardEntry>> getEntries() async {
    final querySnapshot =
        await leaderboard.orderBy("score", descending: true).limit(10).get();
    List<LeaderboardEntry> leaderboardEntries = [];
    for (var element in querySnapshot.docs) {
      final json = element.data() as Map<String, dynamic>;
      final entry = LeaderboardEntry.fromJson(json);
      leaderboardEntries.add(entry);
    }
    return leaderboardEntries;
  }

  Future<int?> getUserRank(String userId) async {
    final querySnapshot =
        await leaderboard.orderBy("score", descending: true).limit(10).get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      final json = querySnapshot.docs[i].data() as Map<String, dynamic>;
      final entry = LeaderboardEntry.fromJson(json);
      if (entry.userId == userId) {
        return i + 1;
      }
    }
    return null;
  }

  Future<void> postEntry(String userId, String userName, int score) async {
    final querySnapshot =
        await leaderboard.where("userId", isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await leaderboard.doc(docId).delete();
    }

    final entry =
        LeaderboardEntry(userId: userId, name: userName, score: score).toJson();
    await leaderboard.add(entry);
  }
}
