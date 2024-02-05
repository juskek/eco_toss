import 'package:eco_toss/common_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

@singleton
class AppVersionLocalDataSource {
  /// Retrieves the version of the app currently installed on the user device
  /// and stores it in state.
  Future<int> getInstalledVersionNo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return int.parse(packageInfo.buildNumber);
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }
}
