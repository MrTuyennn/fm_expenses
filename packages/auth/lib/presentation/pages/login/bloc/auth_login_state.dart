import 'package:auth/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class AuthLoginState extends Equatable {
  const AuthLoginState({this.auth = const AuthDataEntities()});

  final IAuthDataEntities auth;

  @override
  List<Object?> get props => [auth];

  AuthLoginState copyWith({IAuthDataEntities? newAuth}) {
    return AuthLoginState(auth: newAuth ?? auth);
  }
}
