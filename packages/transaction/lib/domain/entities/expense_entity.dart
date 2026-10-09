abstract class IExpenseEntity {
  const IExpenseEntity({
    this.id = '',
    this.userId = '',
    this.categoryId = '',
    this.amount = 0,
    this.currency = '',
    this.note = '',
    this.spentAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String categoryId;
  final num amount;
  final String currency;
  final String note;
  final DateTime? spentAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class ExpenseEntity extends IExpenseEntity {
  const ExpenseEntity({
    super.id,
    super.userId,
    super.categoryId,
    super.amount,
    super.currency,
    super.note,
    super.spentAt,
    super.createdAt,
    super.updatedAt,
  });
}
