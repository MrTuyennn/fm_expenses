import 'dart:convert';

import 'package:auth/domain/entities/auth_entities.dart';
import 'package:auth/domain/repository/auth_login_repository.dart';
import 'package:auth/domain/usecase/login/auth_login_param.dart';
import 'package:injectable/injectable.dart';
import 'package:service/service.dart';

@LazySingleton(as: AuthLoginRepository)
class AuthLoginRepoImpl implements AuthLoginRepository {
  const AuthLoginRepoImpl({required this.restClient});

  final IRestClient restClient;

  @override
  Future<IAuthEntities> authLogin(IAuthLoginParam params) async {
    final res = await restClient.post(
      '/auth/login',
      jsonEncode(params.toJson()),
    );
    final status = res?.statusCode;
    final data = res?.data;
    print(data);
    throw UnimplementedError();
  }
}
