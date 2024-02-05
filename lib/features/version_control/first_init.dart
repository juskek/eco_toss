import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/version_control/app_version_control.dart';
import 'package:eco_toss/features/version_control/app_view_model.dart';

class FirstInit {
  static Future<AppVersionStatus> init(BuildContext context) async {
    print('FirstInit: init: getting app version status');
    AppVersionStatus appVersionStatus =
        await getIt<AppViewModel>().checkIfAppUpdateIsNecessary(context);
    print('appVersionStatus: $appVersionStatus');
    return appVersionStatus;
  }
}
