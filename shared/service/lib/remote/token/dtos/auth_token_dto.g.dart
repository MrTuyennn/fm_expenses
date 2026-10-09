// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenDto _$AuthTokenDtoFromJson(Map<String, dynamic> json) => AuthTokenDto(
  accessToken: json['access_token'] as String? ?? '',
  refreshToken: json['refresh_token'] as String? ?? '',
  expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
  tokenType: json['token_type'] as String? ?? '',
);

Map<String, dynamic> _$AuthTokenDtoToJson(AuthTokenDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'token_type': instance.tokenType,
    };
