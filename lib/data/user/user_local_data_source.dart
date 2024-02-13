import 'package:eco_toss/data/user/eco_toss_user.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserLocalDataSource {
  static const String hiveBoxName = 'UserLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  EcoTossUser get ecoTossUser {
    print('ecoTossUser');
    print(box.get('ecoTossUser'));
    // final jsonString = box.get('ecoTossUser') as String;

    // final json = jsonDecode(jsonString) as Map<String, dynamic>;
    // return EcoTossUser.fromJson(json);
    return EcoTossUser(userId: '123');
  }

  Future<String> get userId async {
    final userId = (await box.get('userId')) as String;
    return userId;
  }

  void setUserId(String userId) {
    box.put("userId", userId);
  }
}
