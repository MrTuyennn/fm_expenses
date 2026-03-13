import 'package:auth/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dto/dtos.dart';

final class AuthUserConverter
    extends JsonConverter<IAuthUserEntities, Map<String, dynamic>> {
  const AuthUserConverter();

  @override
  IAuthUserEntities fromJson(Map<String, dynamic> json) {
    return AuthUserDto.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(IAuthUserEntities object) {
    return AuthUserDto(
      id: object.id,
      username: object.username,
      role: object.role,
    ).toJson();
  }
}
