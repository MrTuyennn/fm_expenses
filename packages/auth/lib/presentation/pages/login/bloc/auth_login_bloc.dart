import 'package:app_logger/logger.dart';
import 'package:auth/data/usecase_params/auth_login_param.dart';
import 'package:auth/domain/usecase/login/auth_login_param.dart';
import 'package:auth/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:service/service.dart';

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
      emit(state.copyWith(newType: AuthLoginType.loading));
      IAuthLoginParam prams = event.params;
      final params = AuthLoginParam(
        username: prams.username,
        password: prams.password,
      );
      final result = await authLoginUseCase.call(params);
      result.when(
        success: (re) {
          logger.e(re);
        },
        failure: (e) {
          logger.d(e);
        },
      );
      emit(state.copyWith(newType: AuthLoginType.success));
    } catch (e) {
      logger.e(e);
    }
  }
}
