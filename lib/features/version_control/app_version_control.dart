import 'dart:convert';

import 'package:eco_toss/features/version_control/app_version.dart';

enum AppVersionStatus {
  latest, // no update required, app version is either latest
  supported, // no update required, app version is not latest but it is not being deprecated yet
  deprecating, // update required by certain date, app version is being deprecated
  deprecated, // update required before use
}

class AppVersionControl {
  final AppVersion latest;
  final DeprecatingAppVersion deprecating;
  final AppVersion deprecated;

  AppVersionControl._({
    required this.latest,
    required this.deprecating,
    required this.deprecated,
  });

  factory AppVersionControl(String response) {
    dynamic responseJson = jsonDecode(response);

    final appVersionControl = AppVersionControl._(
      latest: AppVersion(responseJson['latest'] as String),
      deprecating: DeprecatingAppVersion(
          responseJson['deprecating']['version'] as String,
          responseJson['deprecating']['date'] as String),
      deprecated: AppVersion(responseJson['deprecated'] as String),
    );
    return appVersionControl;
  }

  AppVersionStatus isAppUpdateRequired(AppVersion appVersion) {
    if (appVersion.intValue >= latest.intValue) {
      return AppVersionStatus.latest;
    } else if (appVersion.intValue > deprecating.intValue) {
      return AppVersionStatus.supported;
    } else if (appVersion.intValue <= deprecating.intValue &&
        appVersion.intValue > deprecated.intValue) {
      return AppVersionStatus.deprecating;
    } else if (appVersion.intValue <= deprecated.intValue) {
      return AppVersionStatus.deprecated;
    } else {
      throw UnimplementedError('AppVersionControl: isAppUpdateRequired');
    }
  }
}
