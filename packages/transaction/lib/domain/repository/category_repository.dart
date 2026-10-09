import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/usecase/params/params.dart';

abstract class CategoryRepository {
  Future<Iterable<ICategoryEntity>> getCategories();

  Future<ICategoryEntity> getCategory(String id);

  Future<ICategoryEntity> createCategory(CreateCategoryParam param);

  Future<ICategoryEntity> updateCategory(UpdateCategoryParam param);

  Future<void> deleteCategory(String id);
}
