import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfoLocalDataSource {
  /// Retrieves the version of the app currently installed on the user device
  /// and stores it in state.
  static Future<PackageInfo> getInstalledAppVersion() async {
    return await PackageInfo.fromPlatform();
  }
}
