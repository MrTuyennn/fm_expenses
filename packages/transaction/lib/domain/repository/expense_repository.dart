import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/usecase/params/params.dart';

abstract class ExpenseRepository {
  Future<Iterable<IExpenseEntity>> getExpenses(ExpenseFilterParam filter);

  Future<IExpenseEntity> getExpense(String id);

  Future<IExpenseEntity> createExpense(CreateExpenseParam param);

  Future<IExpenseEntity> updateExpense(UpdateExpenseParam param);

  Future<void> deleteExpense(String id);
}
