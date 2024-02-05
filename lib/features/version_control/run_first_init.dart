import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/version_control/app_version_control.dart';
import 'package:eco_toss/features/version_control/first_init.dart';
import 'package:eco_toss/features/version_control/init_screen.dart';

/// First Screen which is shown when the app starts, before auth
class RunFirstInit extends StatelessWidget {
  static const routeName = '/RunFirstInit';
  const RunFirstInit({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirstInit.init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData &&
              snapshot.data.runtimeType == AppVersionStatus) {
            if (snapshot.data == AppVersionStatus.latest ||
                snapshot.data == AppVersionStatus.supported ||
                snapshot.data == AppVersionStatus.deprecating) {
              return child;
            } else if (snapshot.data == AppVersionStatus.deprecated) {
              return const InitScreen(message: 'Please update your app!');
            } else {
              throw UnimplementedError(
                  'RunFirstInit: FutureBuilder: uncaught case in AppVersionStatus');
            }
          } else {
            throw UnimplementedError(
                'RunFirstInit: FutureBuilder: uncaught case in snapshot.hasData: ${snapshot.hasData}  and snapshot.data.runtimeType: ${snapshot.data.runtimeType}');
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const InitScreen(
            message: 'Initialising',
          );
        } else {
          throw UnimplementedError(
              'RunFirstInit: FutureBuilder: uncaught case in connectionState');
        }
      },
    );
  }
}
