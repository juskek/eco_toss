import 'package:injectable/injectable.dart';

import './i_new_user_repository.dart';
import './new_user_local_data_source.dart';
import './new_user_remote_data_source.dart';

@Singleton(as: INewUserRepository)
class NewUserRepository implements INewUserRepository {
  NewUserRepository(
      this._newUserLocalDataSource, this._newUserRemoteDataSource);

  final NewUserLocalDataSource _newUserLocalDataSource;
  final NewUserRemoteDataSource _newUserRemoteDataSource;

  @override
  Future<bool> get hasPlayedTutorial async {
    return await _newUserLocalDataSource.hasPlayedTutorial;
  }

  @override
  Future<bool> get hasOnboarded async {
    return await _newUserLocalDataSource.hasOnboarded;
  }

  @override
  Future<void> setHasPlayedTutorial(bool _) async {
    return await _newUserLocalDataSource.setHasPlayedTutorial(_);
  }

  @override
  Future<void> setHasOnboarded(bool _) async {
    return await _newUserLocalDataSource.setHasOnboarded(_);
  }
}
