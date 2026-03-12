import 'package:app_logger/logger.dart';
import 'package:auth/data/usecase_params/auth_login_param.dart';
import 'package:auth/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'auth_login_event.dart';
import 'auth_login_state.dart';

@lazySingleton
class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final AuthLoginUseCase authLoginUseCase;

  AuthLoginBloc(this.authLoginUseCase) : super(const AuthLoginState()) {
    on<AuthLogin>(login);
  }

  void login(AuthLogin event, Emitter emit) {
    try {
      final params = AuthLoginParam(username: 'ROT', password: 'rot@123');
      final data = authLoginUseCase.call(params);
      logger.d(data);
    } catch (e) {
      logger.e(e);
    }
  }
}
