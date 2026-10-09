import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:providers/user/domain/usecase/usecase.dart';
import 'package:service/service.dart';

part 'user_event.dart';
part 'user_state.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.getUserUseCase) : super(UserState()) {
    on<GetUserEvent>(_getUserEvent);
    on<UserLoggedOut>(_userLoggedOut);
  }

  final GetUserUseCase getUserUseCase;

  void _getUserEvent(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(newUserType: UserType.loading));
    final result = await getUserUseCase.call();
    result.when(
      success: (value) {
        emit(state.copyWith(newUserType: UserType.success, newUser: value));
      },
      failure: (error) {
        emit(state.copyWith(newUserType: UserType.error));
      },
    );
  }

  void _userLoggedOut(UserLoggedOut event, Emitter emit) {
    emit(
      state.copyWith(newUserType: UserType.error, newUser: const UserEntity()),
    );
  }
}
