import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/data/dtos/category_dto.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/category_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl with ApiScopeMixin implements CategoryRepository {
  const CategoryRepositoryImpl(this.restClient);

  final IRestClient restClient;

  @override
  Future<Iterable<ICategoryEntity>> getCategories() {
    return runApiScope(
      request: () => restClient.get('/categories'),
      deserialize: (json) => (json as List)
          .map(
            (e) => CategoryDto.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList(),
    );
  }

  @override
  Future<ICategoryEntity> getCategory(String id) {
    return runApiScope(
      request: () => restClient.get('/categories/$id'),
      deserialize: (json) =>
          CategoryDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<ICategoryEntity> createCategory(CreateCategoryParam param) {
    return runApiScope(
      request: () => restClient.post('/categories', jsonEncode(param.toJson())),
      deserialize: (json) =>
          CategoryDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<ICategoryEntity> updateCategory(UpdateCategoryParam param) {
    return runApiScope(
      request: () =>
          restClient.put('/categories/${param.id}', jsonEncode(param.toJson())),
      deserialize: (json) =>
          CategoryDto.fromJson(json as Map<String, dynamic>).toEntity(),
    );
  }

  @override
  Future<void> deleteCategory(String id) {
    return runApiScopeVoid(
      request: () => restClient.delete('/categories/$id', null),
    );
  }
}
