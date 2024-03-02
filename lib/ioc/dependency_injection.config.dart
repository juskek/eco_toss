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
import '../data/leaderboard/i_leaderboard_repository.dart' as _i17;
import '../data/leaderboard/leaderboard_local_data_source.dart' as _i7;
import '../data/leaderboard/leaderboard_remote_data_source.dart' as _i8;
import '../data/leaderboard/leaderboard_repository.dart' as _i18;
import '../data/new_user/i_new_user_repository.dart' as _i19;
import '../data/new_user/new_user_local_data_source.dart' as _i9;
import '../data/new_user/new_user_remote_data_source.dart' as _i10;
import '../data/new_user/new_user_repository.dart' as _i20;
import '../data/score/i_score_repository.dart' as _i21;
import '../data/score/score_local_data_source.dart' as _i11;
import '../data/score/score_remote_data_source.dart' as _i12;
import '../data/score/score_repository.dart' as _i22;
import '../data/user/i_user_repository.dart' as _i23;
import '../data/user/user_local_data_source.dart' as _i14;
import '../data/user/user_remote_data_source.dart' as _i15;
import '../data/user/user_repository.dart' as _i24;
import '../features/app_version_control/app_version_control_view_model.dart'
    as _i16;
import '../features/flame_game/game_implementations/main/game_view_model.dart'
    as _i27;
import '../features/flame_game/game_implementations/main/sprite_view_model.dart'
    as _i13;
import '../features/name/name_viewmodel.dart' as _i26;
import '../pages/leaderboard_page/leaderboard_viewmodel.dart' as _i25;

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
  gh.singleton<_i9.NewUserLocalDataSource>(_i9.NewUserLocalDataSource());
  gh.singleton<_i10.NewUserRemoteDataSource>(_i10.NewUserRemoteDataSource());
  gh.singleton<_i11.ScoreLocalDataSource>(_i11.ScoreLocalDataSource());
  gh.singleton<_i12.ScoreRemoteDataSource>(_i12.ScoreRemoteDataSource());
  gh.factory<_i13.SpriteViewModel>(() => _i13.SpriteViewModel());
  gh.singleton<_i14.UserLocalDataSource>(_i14.UserLocalDataSource());
  gh.singleton<_i15.UserRemoteDataSource>(_i15.UserRemoteDataSource());
  gh.factory<_i16.AppVersionControlViewModel>(
      () => _i16.AppVersionControlViewModel(gh<_i5.IAppVersionRepository>()));
  gh.singleton<_i17.ILeaderboardRepository>(_i18.LeaderboardRepository(
    gh<_i7.LeaderboardLocalDataSource>(),
    gh<_i8.LeaderboardRemoteDataSource>(),
  ));
  gh.singleton<_i19.INewUserRepository>(_i20.NewUserRepository(
    gh<_i9.NewUserLocalDataSource>(),
    gh<_i10.NewUserRemoteDataSource>(),
  ));
  gh.singleton<_i21.IScoreRepository>(_i22.ScoreRepository(
    gh<_i11.ScoreLocalDataSource>(),
    gh<_i12.ScoreRemoteDataSource>(),
  ));
  gh.singleton<_i23.IUserRepository>(_i24.UserRepository(
    gh<_i14.UserLocalDataSource>(),
    gh<_i15.UserRemoteDataSource>(),
  ));
  gh.factory<_i25.LeaderboardViewModel>(() => _i25.LeaderboardViewModel(
        gh<_i23.IUserRepository>(),
        gh<_i17.ILeaderboardRepository>(),
        gh<_i21.IScoreRepository>(),
      ));
  gh.factory<_i26.NameViewModel>(
      () => _i26.NameViewModel(gh<_i23.IUserRepository>()));
  gh.factory<_i27.GameViewModel>(() => _i27.GameViewModel(
        gh<_i21.IScoreRepository>(),
        gh<_i17.ILeaderboardRepository>(),
        gh<_i23.IUserRepository>(),
      ));
  return getIt;
}
