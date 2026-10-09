enum CategoryType { income, expense }

abstract class ICategoryEntity {
  const ICategoryEntity({
    this.id = '',
    this.userId = '',
    this.name = '',
    this.icon = '',
    this.type = CategoryType.expense,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String name;
  final String icon;
  final CategoryType type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class CategoryEntity extends ICategoryEntity {
  const CategoryEntity({
    super.id,
    super.userId,
    super.name,
    super.icon,
    super.type,
    super.createdAt,
    super.updatedAt,
  });
}
