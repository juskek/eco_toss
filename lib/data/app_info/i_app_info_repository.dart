import 'package:eco_toss/features/version_control/app_version_control.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class IAppInfoRepository {
  //! App Version Control
  AppVersionControl? _appVersionControl;
  AppVersionControl? get appVersionControl => _appVersionControl;

  AppVersionStatus? _appVersionStatus;
  AppVersionStatus? get appVersionStatus => _appVersionStatus;

  PackageInfo? _packageInfo;

  String get majorMinorRevisionBuildString => _packageInfo == null
      ? 'ERROR: AppState: Package Info is null'
      : '${_packageInfo!.version}+${_packageInfo!.buildNumber}';

  Future<AppVersionStatus> checkIfAppUpdateIsNecessary();
}
