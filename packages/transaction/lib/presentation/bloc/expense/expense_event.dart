part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class LoadExpenses extends ExpenseEvent {
  LoadExpenses({this.filter = const ExpenseFilterParam()});

  final ExpenseFilterParam filter;
}

final class CreateExpense extends ExpenseEvent {
  CreateExpense(this.param);

  final CreateExpenseParam param;
}

final class UpdateExpense extends ExpenseEvent {
  UpdateExpense(this.param);

  final UpdateExpenseParam param;
}

final class DeleteExpense extends ExpenseEvent {
  DeleteExpense(this.id);

  final String id;
}
