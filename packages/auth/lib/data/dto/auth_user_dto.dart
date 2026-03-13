import 'package:auth/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_dto.g.dart';

extension AuthUserDtoX on AuthUserDto {
  IAuthUserEntities toEntity() {
    return AuthUserEntities(id: id, username: username, role: role);
  }
}

@JsonSerializable()
class AuthUserDto {
  const AuthUserDto({this.id = '', this.username = '', this.role = ''});

  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);

  final String id;
  final String username;
  final String role;

  Map<String, dynamic> toJson() => _$AuthUserDtoToJson(this);
}
