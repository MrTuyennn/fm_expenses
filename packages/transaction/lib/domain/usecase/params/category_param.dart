import 'package:json_annotation/json_annotation.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';

part 'category_param.g.dart';

/// Request body for `POST /categories`.
@JsonSerializable(createFactory: false)
class CreateCategoryParam implements IParam {
  const CreateCategoryParam({
    required this.name,
    required this.icon,
    required this.type,
  });

  final String name;
  final String icon;
  final CategoryType type;

  @override
  Map<String, dynamic> toJson() => _$CreateCategoryParamToJson(this);
}

/// Request body for `PUT /categories/{id}` — the API requires the full
/// object (name/icon/type), not a partial update.
@JsonSerializable(createFactory: false)
class UpdateCategoryParam implements IParam {
  const UpdateCategoryParam({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });

  @JsonKey(includeToJson: false)
  final String id;
  final String name;
  final String icon;
  final CategoryType type;

  @override
  Map<String, dynamic> toJson() => _$UpdateCategoryParamToJson(this);
}
