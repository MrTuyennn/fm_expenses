import 'package:auth/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

enum AuthLoginType { init, loading, success, error }

class AuthLoginState extends Equatable {
  const AuthLoginState({
    this.auth = const AuthDataEntities(),
    this.loginType = AuthLoginType.init,
    this.errorMessage,
  });

  final IAuthDataEntities auth;
  final AuthLoginType loginType;
  final String? errorMessage;

  @override
  List<Object?> get props => [auth, loginType, errorMessage];

  AuthLoginState copyWith({
    IAuthDataEntities? newAuth,
    AuthLoginType? newType,
    String? newErrorMessage,
  }) {
    final resolvedType = newType ?? loginType;
    return AuthLoginState(
      auth: newAuth ?? auth,
      loginType: resolvedType,
      errorMessage: resolvedType == AuthLoginType.error
          ? newErrorMessage
          : null,
    );
  }
}
