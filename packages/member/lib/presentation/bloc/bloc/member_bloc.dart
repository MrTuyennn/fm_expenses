import 'package:app_logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:member/domain/usecase/usecase.dart';
import 'package:service/service.dart';

part 'member_event.dart';
part 'member_state.dart';

@lazySingleton
class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc({required this.getMemberUsecase}) : super(MemberState()) {
    on<GetMemberEvent>(_getMemberEvent);
  }

  final GetMemberUsecase getMemberUsecase;

  void _getMemberEvent(GetMemberEvent event, Emitter emit) async {
    final result = await getMemberUsecase.call();
    result.when(
      success: (value) {
        logger.d(value);
      },
      failure: (error) {
        logger.e(error);
      },
    );
  }
}
