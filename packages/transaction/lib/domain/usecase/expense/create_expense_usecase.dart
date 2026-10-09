import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class CreateExpenseUseCase
    extends UseCase<Result<IExpenseEntity>, CreateExpenseParam> {
  const CreateExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  @override
  Future<Result<IExpenseEntity>> call(CreateExpenseParam param) {
    return Result.guardFuture(() => expenseRepository.createExpense(param));
  }
}
