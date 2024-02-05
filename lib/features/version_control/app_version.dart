class AppVersion {
  // const AppVersion(this.majorMinorRevisionBuildString): major = majorMinorRevisionBuildString.split('.')[0],minor = majorMinorRevisionBuildString.split('.')[1], revision = majorMinorRevisionBuildString.split('.')[1], build = revision = majorMinorRevisionBuildString.split('.')[1];

  const AppVersion._(this.major, this.minor, this.revision, this.build);

  /// majorMinorRevisionBuildString must be formatted as X.Y.Z+A
  factory AppVersion(String majorMinorRevisionBuildString) {
    try {
      int major = int.parse(majorMinorRevisionBuildString.split('.')[0]);
      int minor = int.parse(majorMinorRevisionBuildString.split('.')[1]);
      int revision = int.parse(
          (majorMinorRevisionBuildString.split('.')[2]).split('+')[0]);
      int build = int.parse(
          (majorMinorRevisionBuildString.split('.')[2]).split('+')[1]);

      return AppVersion._(major, minor, revision, build);
    } catch (e) {
      print('AppVersion: error: $e');
      rethrow;
    }
  }

  final int major;
  final int minor;
  final int revision;
  final int build;
  int get intValue => major * 1000 + minor * 100 + revision * 10 + build;
}

class DeprecatingAppVersion extends AppVersion {
  DeprecatingAppVersion._(super.major, super.minor, super.revision, super.build,
      this.deprecatingDateTime)
      : super._();

  factory DeprecatingAppVersion(
      String majorMinorRevisionBuildString, String dateTimeString) {
    int major = int.parse(majorMinorRevisionBuildString.split('.')[0]);
    int minor = int.parse(majorMinorRevisionBuildString.split('.')[1]);
    int revision =
        int.parse((majorMinorRevisionBuildString.split('.')[2]).split('+')[0]);
    int build =
        int.parse((majorMinorRevisionBuildString.split('.')[2]).split('+')[1]);
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DeprecatingAppVersion._(major, minor, revision, build, dateTime);
  }

  final DateTime deprecatingDateTime;
  String get deprecatingDateTimeString =>
      '${deprecatingDateTime.day}-${deprecatingDateTime.month}-${deprecatingDateTime.year} ${deprecatingDateTime.hour}:${deprecatingDateTime.minute}';
}
