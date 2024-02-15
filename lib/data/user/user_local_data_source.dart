import 'dart:convert';

import 'package:eco_toss/data/user/eco_toss_user.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserLocalDataSource {
  static const String hiveBoxName = 'UserLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  Future<EcoTossUser> get ecoTossUser async {
    final jsonString = (await box.get('ecoTossUser')) as String;
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return EcoTossUser.fromJson(json);
  }

  Future<String> get userId async {
    final userId = (await box.get('userId')) as String;
    return userId;
  }

  void setUserId(String userId) {
    box.put("userId", userId);
  }

  Future<String?> get playerName async {
    final playerName = (await box.get('playerName')) as String?;
    return playerName;
  }

  Future<void> setPlayerName(String name) async {
    await box.put('playerName', name);
  }
}
