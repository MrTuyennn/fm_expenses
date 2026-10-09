import 'dart:convert';

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
    final tokens = await runApiScope(
      request: () =>
          restClient.post('/auth/login', jsonEncode(params.toJson())),
      deserialize: (json) =>
          AuthTokenDto.fromJson(json as Map<String, dynamic>),
    );

    await tokenService.saveToken(tokens.accessToken, tokens.refreshToken);

    return AuthDataEntities(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }
}
