import 'package:json_annotation/json_annotation.dart';
import 'package:service/service.dart';

part 'expense_param.g.dart';

String _dateTimeToJson(DateTime dateTime) => dateTime.toUtc().toIso8601String();

/// Request body for `POST /expenses`.
@JsonSerializable(createFactory: false)
class CreateExpenseParam implements IParam {
  const CreateExpenseParam({
    required this.categoryId,
    required this.amount,
    required this.currency,
    this.note = '',
    required this.spentAt,
  });

  @JsonKey(name: 'category_id')
  final String categoryId;
  final num amount;
  final String currency;
  final String note;
  @JsonKey(name: 'spent_at', toJson: _dateTimeToJson)
  final DateTime spentAt;

  @override
  Map<String, dynamic> toJson() => _$CreateExpenseParamToJson(this);
}

/// Request body for `PUT /expenses/{id}` — full-replace, same shape as create.
@JsonSerializable(createFactory: false)
class UpdateExpenseParam implements IParam {
  const UpdateExpenseParam({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.currency,
    this.note = '',
    required this.spentAt,
  });

  @JsonKey(includeToJson: false)
  final String id;
  @JsonKey(name: 'category_id')
  final String categoryId;
  final num amount;
  final String currency;
  final String note;
  @JsonKey(name: 'spent_at', toJson: _dateTimeToJson)
  final DateTime spentAt;

  @override
  Map<String, dynamic> toJson() => _$UpdateExpenseParamToJson(this);
}

/// Optional filters for `GET /expenses?category_id=&from=&to=`.
class ExpenseFilterParam implements IParam {
  const ExpenseFilterParam({this.categoryId, this.from, this.to});

  final String? categoryId;
  final DateTime? from;
  final DateTime? to;

  Map<String, dynamic> toQueryParameters() => {
    if (categoryId != null) 'category_id': categoryId,
    if (from != null) 'from': from!.toUtc().toIso8601String(),
    if (to != null) 'to': to!.toUtc().toIso8601String(),
  };

  @override
  Map<String, dynamic> toJson() => {};
}
