import 'package:auth/domain/usecase/login/auth_login_param.dart';

class AuthLoginParam extends IAuthLoginParam {
  const AuthLoginParam({required super.login, required super.password});

  // Backend expects {"email": ..., "password": ...} — `login` here is the
  // account email.
  @override
  Map<String, dynamic> toJson() => {'email': login, 'password': password};
}
