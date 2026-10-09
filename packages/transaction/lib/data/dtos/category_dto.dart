import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transaction/domain/entities/entities.dart';

part 'category_dto.g.dart';

extension CategoryDtoX on CategoryDto {
  ICategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      userId: userId,
      name: name,
      icon: icon,
      type: type,
      createdAt: DateTime.tryParse(createdAt),
      updatedAt: DateTime.tryParse(updatedAt),
    );
  }
}

@JsonSerializable()
class CategoryDto {
  const CategoryDto({
    this.id = '',
    @JsonKey(name: 'user_id') this.userId = '',
    this.name = '',
    this.icon = '',
    this.type = CategoryType.expense,
    @JsonKey(name: 'created_at') this.createdAt = '',
    @JsonKey(name: 'updated_at') this.updatedAt = '',
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  final String id;
  final String userId;
  final String name;
  final String icon;
  final CategoryType type;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
