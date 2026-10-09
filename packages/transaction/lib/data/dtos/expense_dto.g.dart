// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDto _$ExpenseDtoFromJson(Map<String, dynamic> json) => ExpenseDto(
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  categoryId: json['category_id'] as String? ?? '',
  amount: json['amount'] as num? ?? 0,
  currency: json['currency'] as String? ?? '',
  note: json['note'] as String? ?? '',
  spentAt: json['spent_at'] as String? ?? '',
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
);

Map<String, dynamic> _$ExpenseDtoToJson(ExpenseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'currency': instance.currency,
      'note': instance.note,
      'spent_at': instance.spentAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
