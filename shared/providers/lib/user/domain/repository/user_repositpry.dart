import 'package:providers/user/domain/entities/entities.dart';

abstract class UserRepositpry {
  Future<IUserEntity> getUser();

  Future<Iterable<IUserEntity>> getListUsers();
}
