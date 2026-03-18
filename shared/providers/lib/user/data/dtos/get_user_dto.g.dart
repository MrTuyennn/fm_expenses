// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDto _$GetUserDtoFromJson(Map<String, dynamic> json) => GetUserDto(
  id: json['id'] as String? ?? '',
  username: json['username'] as String? ?? '',
  nickname: json['nickname'] as String? ?? '',
  role: json['role'] as String? ?? '',
  createdAt: json['createdAt'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
);

Map<String, dynamic> _$GetUserDtoToJson(GetUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'role': instance.role,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
