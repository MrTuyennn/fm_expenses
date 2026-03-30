import 'package:injectable/injectable.dart';
import 'package:providers/user/data/dtos/get_user_dto.dart';
import 'package:providers/user/data/dtos/list_user_dto.dart';
import 'package:providers/user/domain/entities/user_entity.dart';
import 'package:providers/user/domain/repository/user_repositpry.dart';
import 'package:service/service.dart';

@LazySingleton(as: UserRepositpry)
class UserRepositoryImpl with ApiScopeMixin implements UserRepositpry {
  const UserRepositoryImpl({required this.restClient});

  final IRestClient restClient;

  @override
  Future<IUserEntity> getUser() async {
    final data = await runApiScope(
      request: () => restClient.get('/users/me'),
      deserialize: GetUserDto.fromJson,
    );
    return data.toEntity();
  }

  @override
  Future<Iterable<IUserEntity>> getListUsers() async {
    final data = await runApiScope(
      request: () => restClient.get('/users'),
      deserialize: ListUserDto.fromJson,
    );

    return data.items;
  }
}
