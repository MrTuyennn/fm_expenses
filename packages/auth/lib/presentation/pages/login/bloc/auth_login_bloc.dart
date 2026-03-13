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

  void login(AuthLogin event, Emitter emit) async {
    try {
      final params = AuthLoginParam(username: 'ROT', password: 'rot2@123');
      final result = await authLoginUseCase.call(params);
      result.on(
        success: (value) {
          logger.d(value);
        },
        failure: (failure) {
          logger.d(failure.type);
        },
      );
    } catch (e) {
      logger.e(e);
    }
  }
}
