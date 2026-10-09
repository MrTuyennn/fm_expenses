// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDto _$GetUserDtoFromJson(Map<String, dynamic> json) => GetUserDto(
  id: json['id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  fullName: json['full_name'] as String? ?? '',
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
);

Map<String, dynamic> _$GetUserDtoToJson(GetUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
