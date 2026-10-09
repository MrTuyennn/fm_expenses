import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/category_repository.dart';

@lazySingleton
final class GetCategoriesUseCase
    extends NoParamsUseCase<Result<Iterable<ICategoryEntity>>> {
  const GetCategoriesUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<Result<Iterable<ICategoryEntity>>> call() {
    return Result.guardFuture(() => categoryRepository.getCategories());
  }
}
