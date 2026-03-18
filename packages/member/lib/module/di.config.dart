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
import 'package:member/data/repository/get_member_repository_impl.dart'
    as _i963;
import 'package:member/domain/repository/member_repository.dart' as _i274;
import 'package:member/domain/usecase/get_member_usecase.dart' as _i159;
import 'package:member/domain/usecase/usecase.dart' as _i760;
import 'package:member/presentation/bloc/bloc/member_bloc.dart' as _i999;
import 'package:service/service.dart' as _i736;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt member(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i274.MemberRepository>(
    () => _i963.MemberRepositoryImpl(gh<_i736.IRestClient>()),
  );
  gh.lazySingleton<_i159.GetMemberUsecase>(
    () => _i159.GetMemberUsecase(gh<_i274.MemberRepository>()),
  );
  gh.lazySingleton<_i999.MemberBloc>(
    () => _i999.MemberBloc(getMemberUsecase: gh<_i760.GetMemberUsecase>()),
  );
  return getIt;
}
