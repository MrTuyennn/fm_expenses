import 'package:json_annotation/json_annotation.dart';

part 'auth_token_dto.g.dart';

/// Shape of `{"data": {...}}` returned by both
/// `POST /auth/login` and `POST /auth/refresh`.
@JsonSerializable()
class AuthTokenDto {
  const AuthTokenDto({
    @JsonKey(name: 'access_token') this.accessToken = '',
    @JsonKey(name: 'refresh_token') this.refreshToken = '',
    @JsonKey(name: 'expires_in') this.expiresIn = 0,
    @JsonKey(name: 'token_type') this.tokenType = '',
  });

  factory AuthTokenDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenDtoFromJson(json);

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String tokenType;

  Map<String, dynamic> toJson() => _$AuthTokenDtoToJson(this);
}
