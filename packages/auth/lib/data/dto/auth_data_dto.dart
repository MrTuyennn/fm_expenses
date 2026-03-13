import 'package:auth/data/converters/converters.dart';
import 'package:auth/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_data_dto.g.dart';

extension AuthDataDtoX on AuthDataDto {
  IAuthDataEntities toEntity() {
    return AuthDataEntities(
      refreshToken: refreshToken,
      accessToken: accessToken,
      user: user,
    );
  }
}

@JsonSerializable()
@AuthUserConverter()
class AuthDataDto {
  const AuthDataDto({
    this.accessToken = '',
    this.refreshToken = '',
    this.user = const AuthUserEntities(),
  });

  factory AuthDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDataDtoFromJson(json);

  final String accessToken;
  final String refreshToken;
  final IAuthUserEntities user;

  Map<String, dynamic> toJson() => _$AuthDataDtoToJson(this);
}
