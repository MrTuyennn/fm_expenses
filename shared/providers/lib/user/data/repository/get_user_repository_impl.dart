import 'package:injectable/injectable.dart';
import 'package:providers/user/data/dtos/get_user_dto.dart';
import 'package:providers/user/domain/entities/user_entity.dart';
import 'package:providers/user/domain/repository/get_user_repositpry.dart';
import 'package:service/service.dart';

@LazySingleton(as: GetUserRepositpry)
class GetUserRepositoryImpl with ApiScopeMixin implements GetUserRepositpry {
  const GetUserRepositoryImpl({required this.restClient});

  final IRestClient restClient;

  @override
  Future<IUserEntity> getUser() async {
    final data = await runApiScope(
      request: () => restClient.get('/user/me'),
      deserialize: GetUserDto.fromJson,
    );
    return data.toEntity();
  }
}
