import 'dart:convert';

import 'package:auth/data/dto/dtos.dart';
import 'package:auth/domain/entities/entities.dart';
import 'package:auth/domain/repository/auth_login_repository.dart';
import 'package:auth/domain/usecase/login/auth_login_param.dart';
import 'package:injectable/injectable.dart';
import 'package:service/service.dart';

@LazySingleton(as: AuthLoginRepository)
class AuthLoginRepoImpl with ApiScopeMixin implements AuthLoginRepository {
  const AuthLoginRepoImpl({
    required this.restClient,
    required this.tokenService,
  });

  final IRestClient restClient;
  final ITokenService tokenService;

  @override
  Future<IAuthDataEntities> authLogin(IAuthLoginParam params) async {
    final data = await runApiScope<AuthDataDto>(
      request: () =>
          restClient.post('/auth/login', jsonEncode(params.toJson())),
      deserialize: AuthDataDto.fromJson,
    );
    if (data.accessToken != '') {
      tokenService.saveToken(data.accessToken, data.refreshToken);
    }
    return data.toEntity();
  }
}
