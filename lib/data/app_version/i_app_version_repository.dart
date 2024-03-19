abstract class IAppVersionRepository {
  Future<AppVersionStatus> checkIfAppUpdateIsNecessary();

  Future<int> getInstalledVersionNo();
}

enum AppVersionStatus {
  supported,
  deprecated, // update required before use
}
