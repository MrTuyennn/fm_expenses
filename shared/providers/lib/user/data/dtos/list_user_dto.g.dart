// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListUserDto _$ListUserDtoFromJson(Map<String, dynamic> json) => ListUserDto(
  items:
      (json['items'] as List<dynamic>?)?.map(
        (e) => const UserConverter().fromJson(e as Map<String, dynamic>),
      ) ??
      const [],
);

Map<String, dynamic> _$ListUserDtoToJson(ListUserDto instance) =>
    <String, dynamic>{
      'items': instance.items.map(const UserConverter().toJson).toList(),
    };
