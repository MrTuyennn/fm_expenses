import 'package:providers/user/domain/entities/entities.dart';

abstract class GetUserRepositpry {
  Future<IUserEntity> getUser();
}
