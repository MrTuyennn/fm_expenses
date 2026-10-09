// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateExpenseParamToJson(CreateExpenseParam instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'currency': instance.currency,
      'note': instance.note,
      'spent_at': _dateTimeToJson(instance.spentAt),
    };

Map<String, dynamic> _$UpdateExpenseParamToJson(UpdateExpenseParam instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'currency': instance.currency,
      'note': instance.note,
      'spent_at': _dateTimeToJson(instance.spentAt),
    };
