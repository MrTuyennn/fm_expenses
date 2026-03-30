import 'package:injectable/injectable.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:providers/user/domain/repository/user_repositpry.dart';
import 'package:service/service.dart';

@lazySingleton
final class GetListUserUsecase
    extends NoParamsUseCase<Result<Iterable<IUserEntity>>> {
  const GetListUserUsecase(this.userRepositpry);

  final UserRepositpry userRepositpry;

  @override
  Future<Result<Iterable<IUserEntity>>> call() {
    return Result.guardFuture(() => userRepositpry.getListUsers());
  }
}
