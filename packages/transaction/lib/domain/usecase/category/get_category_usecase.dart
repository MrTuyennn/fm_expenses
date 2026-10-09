import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/repository/category_repository.dart';
import 'package:transaction/domain/usecase/params/params.dart';

@lazySingleton
final class GetCategoryUseCase
    extends UseCase<Result<ICategoryEntity>, IdParam> {
  const GetCategoryUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<Result<ICategoryEntity>> call(IdParam param) {
    return Result.guardFuture(() => categoryRepository.getCategory(param.id));
  }
}
