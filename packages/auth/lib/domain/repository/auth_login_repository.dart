import '../entities/auth_data_entities.dart';
import '../usecase/login/auth_login_param.dart';

abstract class AuthLoginRepository {
  Future<IAuthDataEntities> authLogin(IAuthLoginParam params);
}
