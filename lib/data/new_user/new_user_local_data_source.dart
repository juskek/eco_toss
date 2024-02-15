import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewUserLocalDataSource {
  static const String hiveBoxName = 'NewUserLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  Future<bool> get hasPlayedTutorial async {
    return await box.get('hasPlayedTutorial', defaultValue: false) as bool;
  }

  Future<bool> get hasOnboarded async {
    return await box.get('hasOnboarded', defaultValue: false) as bool;
  }

  Future<void> setHasPlayedTutorial(bool _) async {
    await box.put('hasPlayedTutorial', _);
  }

  Future<void> setHasOnboarded(bool _) async {
    await box.put('hasOnboarded', _);
  }
}
