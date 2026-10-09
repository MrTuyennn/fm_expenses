import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/data/dtos/expense_dto.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/expense_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@LazySingleton(as: ExpenseRepository)
class ExpenseRepositoryImpl with ApiScopeMixin implements ExpenseRepository {
  const ExpenseRepositoryImpl(this.restClient);

  final IRestClient restClient;

  @override
  Future<Iterable<IExpenseEntity>> getExpenses(ExpenseFilterParam filter) {
    return runApiScope(
      request: () => restClient.get(
        '/expenses',
        queryParameters: filter.toQueryParameters(),
      ),
      deserialize: (json) => (json as List)
          .map((e) => ExpenseDto.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
    );
  }

  @override
  Future<IExpenseEntity> getExpense(String id) {
    return runApiScope(
      request: () => restClient.get('/expenses/$id'),
      deserialize: (json) =>
          ExpenseDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<IExpenseEntity> createExpense(CreateExpenseParam param) {
    return runApiScope(
      request: () => restClient.post('/expenses', jsonEncode(param.toJson())),
      deserialize: (json) =>
          ExpenseDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<IExpenseEntity> updateExpense(UpdateExpenseParam param) {
    return runApiScope(
      request: () =>
          restClient.put('/expenses/${param.id}', jsonEncode(param.toJson())),
      deserialize: (json) =>
          ExpenseDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<void> deleteExpense(String id) {
    return runApiScopeVoid(
      request: () => restClient.delete('/expenses/$id', null),
    );
  }
}
