import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:providers/user/domain/repository/user_repositpry.dart';
import 'package:service/service.dart';

@lazySingleton
final class GetUserUseCase extends NoParamsUseCase<Result<IUserEntity>> {
  const GetUserUseCase(this.userRepositpry);

  final UserRepositpry userRepositpry;

  @override
  Future<Result<IUserEntity>> call() {
    return Result.guardFuture(() => userRepositpry.getUser());
  }
}
