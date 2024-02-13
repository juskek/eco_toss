import 'dart:convert';

import 'package:eco_toss/data/user/eco_toss_user.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserLocalDataSource {
  static const String hiveBoxName = 'UserLocalDataSource';
  final box = Hive.lazyBox(hiveBoxName);

  EcoTossUser get ecoTossUser {
    final jsonString = box.get('ecoTossUser') as String;
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return EcoTossUser.fromJson(json);
  }

  String get userId {
    return box.get('userId') as String;
  }

  set userId(String _) {
    box.put("userId", _);
  }
}
