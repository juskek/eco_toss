import 'package:eco_toss/data/user/eco_toss_user.dart';
import 'package:injectable/injectable.dart';

import './i_user_repository.dart';
import './user_local_data_source.dart';
import './user_remote_data_source.dart';

@Singleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._userLocalDataSource, this._userRemoteDataSource);

  final UserLocalDataSource _userLocalDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  @override
  EcoTossUser get ecoTossUser {
    return _userLocalDataSource.ecoTossUser;
  }

  @override
  Future<String> get userId async => _userLocalDataSource.userId;

  @override
  void storeUserId(String userId) {
    _userLocalDataSource.setUserId(userId);
  }
}
