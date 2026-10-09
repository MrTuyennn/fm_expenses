import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transaction/domain/entities/entities.dart';

part 'expense_dto.g.dart';

extension ExpenseDtoX on ExpenseDto {
  IExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      userId: userId,
      categoryId: categoryId,
      amount: amount,
      currency: currency,
      note: note,
      spentAt: DateTime.tryParse(spentAt),
      createdAt: DateTime.tryParse(createdAt),
      updatedAt: DateTime.tryParse(updatedAt),
    );
  }
}

@JsonSerializable()
class ExpenseDto {
  const ExpenseDto({
    this.id = '',
    @JsonKey(name: 'user_id') this.userId = '',
    @JsonKey(name: 'category_id') this.categoryId = '',
    this.amount = 0,
    this.currency = '',
    this.note = '',
    @JsonKey(name: 'spent_at') this.spentAt = '',
    @JsonKey(name: 'created_at') this.createdAt = '',
    @JsonKey(name: 'updated_at') this.updatedAt = '',
  });

  factory ExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDtoFromJson(json);

  final String id;
  final String userId;
  final String categoryId;
  final num amount;
  final String currency;
  final String note;
  final String spentAt;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$ExpenseDtoToJson(this);
}
