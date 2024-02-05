import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/app_info/i_app_info_repository.dart';
import 'package:eco_toss/features/version_control/app_version_control.dart';
import 'package:honeycomb_app/data/main/user/repo/i_user_repository.dart';
import 'package:honeycomb_app/data/misc/app_info/i_app_info_repository.dart';
import 'package:honeycomb_app/utils/index.dart';
import 'package:honeycomb_app/utils/modules/app_version/app_version_control.dart';

// @singleton
class AppViewModel extends ChangeNotifier {
  Future<AppVersionStatus> checkIfAppUpdateIsNecessary(
      BuildContext context) async {
    return await getIt<IAppInfoRepository>().checkIfAppUpdateIsNecessary();
  }

  // void showUpdateNotification(BuildContext context) {
  //   if (getIt<IAppInfoRepository>().appVersionStatus ==
  //       AppVersionStatus.deprecating) {
  //     Styles.notifications.customDropdownNotification(context,
  //         message: AppLocalizations.of(context)!.yourAppVersionSupport(
  //             getIt<IAppInfoRepository>()
  //                 .appVersionControl
  //                 ?.deprecating
  //                 .deprecatingDateTimeString));
  //   }
  // }
}