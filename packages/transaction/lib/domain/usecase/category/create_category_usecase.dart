import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/category_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class CreateCategoryUseCase
    extends UseCase<Result<ICategoryEntity>, CreateCategoryParam> {
  const CreateCategoryUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<Result<ICategoryEntity>> call(CreateCategoryParam param) {
    return Result.guardFuture(() => categoryRepository.createCategory(param));
  }
}
