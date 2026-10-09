import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class UpdateExpenseUseCase
    extends UseCase<Result<IExpenseEntity>, UpdateExpenseParam> {
  const UpdateExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  @override
  Future<Result<IExpenseEntity>> call(UpdateExpenseParam param) {
    return Result.guardFuture(() => expenseRepository.updateExpense(param));
  }
}
