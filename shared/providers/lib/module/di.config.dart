// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:providers/user/bloc/user_bloc.dart' as _i15;
import 'package:providers/user/data/repository/user_repository_impl.dart'
    as _i868;
import 'package:providers/user/domain/repository/user_repositpry.dart' as _i167;
import 'package:providers/user/domain/usecase/get_list_user_usecase.dart'
    as _i355;
import 'package:providers/user/domain/usecase/get_user_usecase.dart' as _i782;
import 'package:providers/user/domain/usecase/usecase.dart' as _i456;
import 'package:service/service.dart' as _i736;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt user(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i167.UserRepositpry>(
    () => _i868.UserRepositoryImpl(restClient: gh<_i736.IRestClient>()),
  );
  gh.lazySingleton<_i355.GetListUserUsecase>(
    () => _i355.GetListUserUsecase(gh<_i167.UserRepositpry>()),
  );
  gh.lazySingleton<_i782.GetUserUseCase>(
    () => _i782.GetUserUseCase(gh<_i167.UserRepositpry>()),
  );
  gh.factory<_i15.UserBloc>(
    () => _i15.UserBloc(
      gh<_i782.GetUserUseCase>(),
      gh<_i456.GetListUserUsecase>(),
    ),
  );
  return getIt;
}
