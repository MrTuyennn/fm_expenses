// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDataDto _$AuthDataDtoFromJson(Map<String, dynamic> json) => AuthDataDto(
  accessToken: json['accessToken'] as String? ?? '',
  refreshToken: json['refreshToken'] as String? ?? '',
  user: json['user'] == null
      ? const AuthUserEntities()
      : const AuthUserConverter().fromJson(
          json['user'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AuthDataDtoToJson(AuthDataDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': const AuthUserConverter().toJson(instance.user),
    };
