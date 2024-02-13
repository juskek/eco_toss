import 'package:eco_toss/data/user/eco_toss_user.dart';

abstract class IUserRepository {
  Future<EcoTossUser> get ecoTossUser;

  Future<String> get userId;

  void storeUserId(String userId);
}
