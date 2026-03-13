// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) => AuthDto(
  success: json['success'] as bool? ?? false,
  data: json['data'] == null
      ? const AuthDataEntities()
      : const AuthDataCoverter().fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthDtoToJson(AuthDto instance) => <String, dynamic>{
  'success': instance.success,
  'data': const AuthDataCoverter().toJson(instance.data),
};
