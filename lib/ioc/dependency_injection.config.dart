// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/app_version/app_version_local_data_source.dart' as _i3;
import '../data/app_version/app_version_remote_data_source.dart' as _i4;
import '../data/app_version/app_version_repository.dart' as _i6;
import '../data/app_version/i_app_version_repository.dart' as _i5;
import '../data/leaderboard/i_leaderboard_repository.dart' as _i12;
import '../data/leaderboard/leaderboard_local_data_source.dart' as _i7;
import '../data/leaderboard/leaderboard_remote_data_source.dart' as _i8;
import '../data/leaderboard/leaderboard_repository.dart' as _i13;
import '../data/user/i_user_repository.dart' as _i14;
import '../data/user/user_local_data_source.dart' as _i9;
import '../data/user/user_remote_data_source.dart' as _i10;
import '../data/user/user_repository.dart' as _i15;
import '../features/app_version_control/app_version_control_view_model.dart'
    as _i11;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppVersionLocalDataSource>(_i3.AppVersionLocalDataSource());
  gh.factory<_i4.AppVersionRemoteDataSource>(
      () => _i4.AppVersionRemoteDataSource());
  gh.singleton<_i5.IAppVersionRepository>(_i6.AppVersionRepository(
    gh<_i3.AppVersionLocalDataSource>(),
    gh<_i4.AppVersionRemoteDataSource>(),
  ));
  gh.singleton<_i7.LeaderboardLocalDataSource>(
      _i7.LeaderboardLocalDataSource());
  gh.singleton<_i8.LeaderboardRemoteDataSource>(
      _i8.LeaderboardRemoteDataSource());
  gh.singleton<_i9.UserLocalDataSource>(_i9.UserLocalDataSource());
  gh.singleton<_i10.UserRemoteDataSource>(_i10.UserRemoteDataSource());
  gh.factory<_i11.AppVersionControlViewModel>(
      () => _i11.AppVersionControlViewModel(gh<_i5.IAppVersionRepository>()));
  gh.singleton<_i12.ILeaderboardRepository>(_i13.LeaderboardRepository(
    gh<_i7.LeaderboardLocalDataSource>(),
    gh<_i8.LeaderboardRemoteDataSource>(),
  ));
  gh.singleton<_i14.IUserRepository>(_i15.UserRepository(
    gh<_i9.UserLocalDataSource>(),
    gh<_i10.UserRemoteDataSource>(),
  ));
  return getIt;
}
