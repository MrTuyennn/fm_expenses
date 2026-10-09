import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class GetExpenseUseCase extends UseCase<Result<IExpenseEntity>, IdParam> {
  const GetExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  @override
  Future<Result<IExpenseEntity>> call(IdParam param) {
    return Result.guardFuture(() => expenseRepository.getExpense(param.id));
  }
}
