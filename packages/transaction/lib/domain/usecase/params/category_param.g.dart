// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateCategoryParamToJson(
  CreateCategoryParam instance,
) => <String, dynamic>{
  'name': instance.name,
  'icon': instance.icon,
  'type': _$CategoryTypeEnumMap[instance.type]!,
};

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};

Map<String, dynamic> _$UpdateCategoryParamToJson(
  UpdateCategoryParam instance,
) => <String, dynamic>{
  'name': instance.name,
  'icon': instance.icon,
  'type': _$CategoryTypeEnumMap[instance.type]!,
};
