import 'package:app_logger/logger.dart';
import 'package:auth/data/usecase_params/auth_login_param.dart';
import 'package:auth/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:providers/providers.dart';
import 'package:service/service.dart';

import 'auth_login_event.dart';
import 'auth_login_state.dart';

@lazySingleton
class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final AuthLoginUseCase authLoginUseCase;

  AuthLoginBloc(this.authLoginUseCase) : super(const AuthLoginState()) {
    on<AuthLogin>(login);
  }

  Future<void> login(AuthLogin event, Emitter emit) async {
    emit(state.copyWith(newType: AuthLoginType.loading));

    final prams = event.params;
    final params = AuthLoginParam(login: prams.login, password: prams.password);

    final result = await authLoginUseCase.call(params);
    result.when(
      success: (auth) {
        // Token đã lưu, verify + lấy thông tin user hiện tại.
        di<UserBloc>().add(GetUserEvent());
        emit(state.copyWith(newAuth: auth, newType: AuthLoginType.success));
      },
      failure: (error) {
        logger.e(error);
        emit(
          state.copyWith(
            newType: AuthLoginType.error,
            newErrorMessage: _friendlyMessage(error),
          ),
        );
      },
    );
  }

  String _friendlyMessage(CoreException error) {
    switch (error.type) {
      case CoreExceptionType.unauthorized:
        return 'Sai email hoặc mật khẩu';
      case CoreExceptionType.network:
        return 'Mất kết nối mạng, vui lòng thử lại';
      case CoreExceptionType.timeout:
        return 'Kết nối quá chậm, vui lòng thử lại';
      default:
        return 'Đăng nhập thất bại, vui lòng thử lại';
    }
  }
}
