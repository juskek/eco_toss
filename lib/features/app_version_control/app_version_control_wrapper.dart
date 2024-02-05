import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/app_version/i_app_version_repository.dart';
import 'package:eco_toss/features/app_version_control/app_version_control_view_model.dart';
import 'package:eco_toss/features/app_version_control/update_app_page.dart';

class AppVersionControlWrapper extends StatelessWidget {
  const AppVersionControlWrapper({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<AppVersionControlViewModel>(),
      builder: (context, child) => FutureBuilder<AppVersionStatus>(
        future: Provider.of<AppVersionControlViewModel>(context)
            .checkAppVersionStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !Provider.of<AppVersionControlViewModel>(context)
                  .appVersionChecked) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.data) {
            case AppVersionStatus.supported:
              Provider.of<AppVersionControlViewModel>(context)
                  .appVersionChecked = true;
              return this.child;
            case AppVersionStatus.deprecated:
              return const UpdateAppPage();
            default:
              return const Icon(Icons.error);
          }
        },
      ),
    );
  }
}
