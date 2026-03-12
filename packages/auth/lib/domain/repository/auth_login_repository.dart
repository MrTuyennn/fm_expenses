import '../entities/auth_entities.dart';
import '../usecase/login/auth_login_param.dart';

abstract class AuthLoginRepository {
  Future<IAuthEntities> authLogin(IAuthLoginParam params);
}
