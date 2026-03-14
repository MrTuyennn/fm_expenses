import 'package:auth/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

enum AuthLoginType { init, loading, success, error }

class AuthLoginState extends Equatable {
  const AuthLoginState({
    this.auth = const AuthDataEntities(),
    this.loginType = AuthLoginType.init,
  });

  final IAuthDataEntities auth;
  final AuthLoginType loginType;

  @override
  List<Object?> get props => [auth, loginType];

  AuthLoginState copyWith({
    IAuthDataEntities? newAuth,
    AuthLoginType? newType,
  }) {
    return AuthLoginState(
      auth: newAuth ?? auth,
      loginType: newType ?? loginType,
    );
  }
}
