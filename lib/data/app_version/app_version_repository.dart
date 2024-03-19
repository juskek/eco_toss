import 'package:eco_toss/common_imports.dart';

import './app_version_local_data_source.dart';
import './app_version_remote_data_source.dart';
import './i_app_version_repository.dart';

@Singleton(as: IAppVersionRepository)
class AppVersionRepository implements IAppVersionRepository {
  AppVersionRepository(
      this._appVersionLocalDataSource, this._appVersionRemoteDataSource);

  final AppVersionLocalDataSource _appVersionLocalDataSource;
  final AppVersionRemoteDataSource _appVersionRemoteDataSource;

  @override
  Future<AppVersionStatus> checkIfAppUpdateIsNecessary() async {
    try {
      final minVersionNo =
          await _appVersionRemoteDataSource.getSupportedAppVersion();
      final currentVersionNo =
          await _appVersionLocalDataSource.getInstalledVersionNo();
      if (minVersionNo > currentVersionNo) {
        return AppVersionStatus.deprecated;
      } else {
        return AppVersionStatus.supported;
      }
    } catch (e) {
      debugPrint('Error in checkIfAppUpdateIsNecessary: $e');
      return AppVersionStatus.deprecated;
    }
  }

  @override
  Future<int> getInstalledVersionNo() async {
    try {
      return await _appVersionLocalDataSource.getInstalledVersionNo();
    } catch (e) {
      debugPrint('Error in getInstalledVersionNo: $e');
      return -1;
    }
  }
}
