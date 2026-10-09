part of 'expense_bloc.dart';

enum ExpenseStatus { init, loading, success, error }

class ExpenseState extends Equatable {
  const ExpenseState({this.status = ExpenseStatus.init, this.items = const []});

  final ExpenseStatus status;
  final Iterable<IExpenseEntity> items;

  @override
  List<Object?> get props => [status, items];

  ExpenseState copyWith({
    ExpenseStatus? newStatus,
    Iterable<IExpenseEntity>? newItems,
  }) {
    return ExpenseState(status: newStatus ?? status, items: newItems ?? items);
  }
}
