import 'package:injectable/injectable.dart';
import 'package:service/service.dart';

import '../../entities/entities.dart';
import '../../repository/auth_login_repository.dart';
import 'auth_login_param.dart';

@injectable
final class AuthLoginUseCase
    extends UseCase<Result<IAuthDataEntities>, IAuthLoginParam> {
  final AuthLoginRepository authLoginRepo;

  const AuthLoginUseCase(this.authLoginRepo);

  @override
  Future<Result<IAuthDataEntities>> call(IAuthLoginParam param) {
    return Result.guardFuture(() => authLoginRepo.authLogin(param));
  }
}
