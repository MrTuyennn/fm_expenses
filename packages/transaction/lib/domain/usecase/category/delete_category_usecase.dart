import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/repository/category_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class DeleteCategoryUseCase extends UseCase<Result<void>, IdParam> {
  const DeleteCategoryUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<Result<void>> call(IdParam param) {
    return Result.guardFuture(
      () => categoryRepository.deleteCategory(param.id),
    );
  }
}
