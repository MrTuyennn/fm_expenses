import 'package:auth/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dto/dtos.dart';

final class AuthDataCoverter
    extends JsonConverter<IAuthDataEntities, Map<String, dynamic>> {
  const AuthDataCoverter();

  @override
  IAuthDataEntities fromJson(Map<String, dynamic> json) {
    return AuthDataDto.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(IAuthDataEntities object) {
    return AuthDataDto(
      refreshToken: object.refreshToken,
      accessToken: object.accessToken,
      user: object.user,
    ).toJson();
  }
}
