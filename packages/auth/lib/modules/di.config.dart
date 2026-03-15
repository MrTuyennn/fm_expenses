// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/data/repository/auth_login_repo_impl.dart' as _i500;
import 'package:auth/domain/repository/auth_login_repository.dart' as _i371;
import 'package:auth/domain/usecase/login/auth_login_usecase.dart' as _i982;
import 'package:auth/domain/usecase/usecase.dart' as _i414;
import 'package:auth/presentation/pages/login/bloc/auth_login_bloc.dart'
    as _i16;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:service/service.dart' as _i736;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt auth(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i371.AuthLoginRepository>(
    () => _i500.AuthLoginRepoImpl(
      restClient: gh<_i736.IRestClient>(),
      tokenService: gh<_i736.ITokenService>(),
    ),
  );
  gh.factory<_i982.AuthLoginUseCase>(
    () => _i982.AuthLoginUseCase(gh<_i371.AuthLoginRepository>()),
  );
  gh.lazySingleton<_i16.AuthLoginBloc>(
    () => _i16.AuthLoginBloc(gh<_i414.AuthLoginUseCase>()),
  );
  return getIt;
}
