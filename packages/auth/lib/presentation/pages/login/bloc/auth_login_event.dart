import 'package:auth/domain/usecase/login/auth_login_param.dart';

sealed class AuthLoginEvent {
  const AuthLoginEvent();
}

final class AuthLogin extends AuthLoginEvent {
  const AuthLogin({required this.params});
  final IAuthLoginParam params;
}
