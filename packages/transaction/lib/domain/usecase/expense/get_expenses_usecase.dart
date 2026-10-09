import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class GetExpensesUseCase
    extends UseCase<Result<Iterable<IExpenseEntity>>, ExpenseFilterParam> {
  const GetExpensesUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  @override
  Future<Result<Iterable<IExpenseEntity>>> call(ExpenseFilterParam param) {
    return Result.guardFuture(() => expenseRepository.getExpenses(param));
  }
}
