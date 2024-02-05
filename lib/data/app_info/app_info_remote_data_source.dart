abstract class AppInfoRemoteDataSource {
  static Future<String> getSupportedAppVersions() async {
    return _mockVersions;
  }
}

String _mockVersions = '''
{
  "latest": "0.5.0+5",
  "deprecating": {
    "version": "0.3.0+4",
    "date": "2024-03-01"
  },
  "deprecated": "0.0.1+3"
}
''';
