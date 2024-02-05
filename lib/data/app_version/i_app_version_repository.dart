abstract class IAppVersionRepository {
  Future<AppVersionStatus> checkIfAppUpdateIsNecessary();
}

enum AppVersionStatus {
  supported,
  deprecated, // update required before use
}
