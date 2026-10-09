import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/category_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class UpdateCategoryUseCase
    extends UseCase<Result<ICategoryEntity>, UpdateCategoryParam> {
  const UpdateCategoryUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<Result<ICategoryEntity>> call(UpdateCategoryParam param) {
    return Result.guardFuture(() => categoryRepository.updateCategory(param));
  }
}
