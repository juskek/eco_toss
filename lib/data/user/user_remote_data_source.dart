import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_toss/common_imports.dart';

@singleton
class UserRemoteDataSource {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> postUserId(String userId) async {
    try {
      await users.doc(userId).set({'userId': userId});
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
