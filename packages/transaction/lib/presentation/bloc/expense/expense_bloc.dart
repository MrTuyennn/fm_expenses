import 'package:app_logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/usecase/usecases.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(
    this.getExpensesUseCase,
    this.createExpenseUseCase,
    this.updateExpenseUseCase,
    this.deleteExpenseUseCase,
  ) : super(const ExpenseState()) {
    on<LoadExpenses>(_onLoad);
    on<CreateExpense>(_onCreate);
    on<UpdateExpense>(_onUpdate);
    on<DeleteExpense>(_onDelete);
  }

  final GetExpensesUseCase getExpensesUseCase;
  final CreateExpenseUseCase createExpenseUseCase;
  final UpdateExpenseUseCase updateExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  Future<void> _onLoad(LoadExpenses event, Emitter emit) async {
    emit(state.copyWith(newStatus: ExpenseStatus.loading));
    final result = await getExpensesUseCase.call(event.filter);
    result.when(
      success: (items) => emit(
        state.copyWith(newStatus: ExpenseStatus.success, newItems: items),
      ),
      failure: (error) {
        logger.e(error);
        emit(state.copyWith(newStatus: ExpenseStatus.error));
      },
    );
  }

  Future<void> _onCreate(CreateExpense event, Emitter emit) async {
    final result = await createExpenseUseCase.call(event.param);
    result.when(
      success: (_) => add(LoadExpenses()),
      failure: (error) => logger.e(error),
    );
  }

  Future<void> _onUpdate(UpdateExpense event, Emitter emit) async {
    final result = await updateExpenseUseCase.call(event.param);
    result.when(
      success: (_) => add(LoadExpenses()),
      failure: (error) => logger.e(error),
    );
  }

  Future<void> _onDelete(DeleteExpense event, Emitter emit) async {
    final result = await deleteExpenseUseCase.call(IdParam(event.id));
    result.when(
      success: (_) => add(LoadExpenses()),
      failure: (error) => logger.e(error),
    );
  }
}
