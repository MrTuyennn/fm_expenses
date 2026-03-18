import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:providers/user/domain/repository/get_user_repositpry.dart';
import 'package:service/service.dart';

@lazySingleton
final class GetUserUseCase extends NoParamsUseCase<Result<IUserEntity>> {
  const GetUserUseCase(this.getUserRepositpry);

  final GetUserRepositpry getUserRepositpry;

  @override
  Future<Result<IUserEntity>> call() {
    return Result.guardFuture(() => getUserRepositpry.getUser());
  }
}
