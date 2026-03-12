import 'package:auth/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class AuthLoginState extends Equatable {
  const AuthLoginState({this.auth = const AuthEntities()});

  final IAuthEntities auth;

  @override
  List<Object?> get props => [auth];

  AuthLoginState copyWith({IAuthEntities? newAuth}) {
    return AuthLoginState(auth: newAuth ?? auth);
  }
}
