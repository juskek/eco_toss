import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewUserLocalDataSource {
  static const String hiveBoxName = 'NewUserLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  Future<bool> get hasPlayedTutorial async {
    // await box.put('hasPlayedTutorial', false);
    // return await box.get('hasPlayedTutorial', defaultValue: false) as bool;
    // removing tutorial for now because it is bugged
    return true;
  }

  Future<bool> get hasOnboarded async {
    // await box.put('hasOnboarded', false);
    return await box.get('hasOnboarded', defaultValue: false) as bool;
  }

  Future<void> setHasPlayedTutorial(bool _) async {
    await box.put('hasPlayedTutorial', _);
  }

  Future<void> setHasOnboarded(bool _) async {
    await box.put('hasOnboarded', _);
  }
}
