import 'package:injectable/injectable.dart';
import 'package:providers/user/data/dtos/get_user_dto.dart';
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
      deserialize: (json) => GetUserDto.fromJson(json as Map<String, dynamic>),
    );
    return data.toEntity();
  }
}
