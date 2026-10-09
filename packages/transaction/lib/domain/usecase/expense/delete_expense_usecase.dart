import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class DeleteExpenseUseCase extends UseCase<Result<void>, IdParam> {
  const DeleteExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  @override
  Future<Result<void>> call(IdParam param) {
    return Result.guardFuture(() => expenseRepository.deleteExpense(param.id));
  }
}
