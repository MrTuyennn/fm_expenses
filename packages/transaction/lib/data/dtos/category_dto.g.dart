// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  type:
      $enumDecodeNullable(_$CategoryTypeEnumMap, json['type']) ??
      CategoryType.expense,
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
);

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'icon': instance.icon,
      'type': _$CategoryTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};
