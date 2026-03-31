import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:providers/user/domain/usecase/get_user_usecase.dart';
import 'package:providers/user/domain/usecase/usecase.dart';
import 'package:service/service.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.getUserUseCase, this.getListUserUsecase) : super(UserState()) {
    on<GetUserEvent>(_getUserEvent);
    on<GetListUserEvent>(_getLsUser);
  }

  final GetUserUseCase getUserUseCase;
  final GetListUserUsecase getListUserUsecase;

  void _getLsUser(GetListUserEvent event, Emitter emit) async {
    final result = await getListUserUsecase.call();
    result.when(
      success: (value) {
        emit(state.copyWith(newUserType: UserType.success, newLsUser: value));
      },
      failure: (error) {
        emit(state.copyWith(newUserType: UserType.error, newLsUser: []));
      },
    );
  }

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
}
