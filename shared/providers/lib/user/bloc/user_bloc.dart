import 'package:app_logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/usecase/get_user_usecase.dart';
import 'package:service/service.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.getUserUseCase) : super(UserState()) {
    on<GetUserEvent>(_getUserEvent);
  }

  final GetUserUseCase getUserUseCase;

  void _getUserEvent(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(newUserType: UserType.loading));
    final result = await getUserUseCase.call();
    result.when(
      success: (value) {
        emit(state.copyWith(newUserType: UserType.success));
        logger.e(value.id);
      },
      failure: (error) {
        emit(state.copyWith(newUserType: UserType.error));
      },
    );
  }
}
