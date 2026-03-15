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
import 'package:service/remote/rest_client.dart' as _i911;
import 'package:service/remote/rest_client.io.dart' as _i802;
import 'package:service/remote/token/itoken_service.dart' as _i329;
import 'package:service/remote/token/token_service.dart' as _i873;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt service(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.singleton<_i329.ITokenService>(() => _i873.TokenService());
  gh.singleton<_i911.IRestClient>(
    () => _i802.RestClient(gh<_i329.ITokenService>()),
  );
  return getIt;
}
