import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/app_version/i_app_version_repository.dart';

@injectable
class AppVersionControlViewModel extends ChangeNotifier {
  AppVersionControlViewModel(this._appVersionRepository);

  final IAppVersionRepository _appVersionRepository;

  bool appVersionChecked = false;

  Future<AppVersionStatus> checkAppVersionStatus() async {
    return await _appVersionRepository.checkIfAppUpdateIsNecessary();
  }
}
