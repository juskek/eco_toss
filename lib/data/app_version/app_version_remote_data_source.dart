import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_toss/common_imports.dart';

@injectable
class AppVersionRemoteDataSource {
  DocumentReference supportedVersions =
      FirebaseFirestore.instance.collection('admin').doc('minVersionNo');

  Future<int> getSupportedAppVersion() async {
    try {
      final docSnap = await supportedVersions.get();
      final data = docSnap.data() as Map<String, dynamic>;
      return data['minVersionNo'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}
