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
import '../features/app_version_control/app_version_control_view_model.dart'
    as _i7;

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
  gh.factory<_i7.AppVersionControlViewModel>(
      () => _i7.AppVersionControlViewModel(gh<_i5.IAppVersionRepository>()));
  return getIt;
}
