import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/app_info/app_info_local_data_source.dart';
import 'package:eco_toss/data/app_info/app_info_remote_data_source.dart';
import 'package:eco_toss/data/app_info/i_app_info_repository.dart';
import 'package:eco_toss/features/version_control/app_version.dart';
import 'package:eco_toss/features/version_control/app_version_control.dart';
import 'package:eco_toss/ioc/dependency_injection.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Singleton(as: IAppInfoRepository, env: [Env.prod])
class AppInfoRepository implements IAppInfoRepository {
  //! App Version Control
  AppVersionControl? _appVersionControl;
  AppVersionStatus _appVersionStatus = AppVersionStatus.supported;

  PackageInfo? _packageInfo;
  @override
  AppVersionControl? get appVersionControl => _appVersionControl;

  @override
  AppVersionStatus get appVersionStatus => _appVersionStatus;

  @override
  String get majorMinorRevisionBuildString => _packageInfo == null
      ? 'ERROR: AppState: Package Info is null'
      : '${_packageInfo!.version}+${_packageInfo!.buildNumber}';

  @override
  Future<AppVersionStatus> checkIfAppUpdateIsNecessary() async {
    _packageInfo = await AppInfoLocalDataSource.getInstalledAppVersion();
    String response = await AppInfoRemoteDataSource.getSupportedAppVersions();

    _appVersionControl = AppVersionControl(response);
    _appVersionStatus = _appVersionControl!
        .isAppUpdateRequired(AppVersion(majorMinorRevisionBuildString));
    return _appVersionStatus;
  }
}
