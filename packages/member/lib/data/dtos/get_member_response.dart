import 'package:json_annotation/json_annotation.dart';
import 'package:member/domain/entities/entities.dart';

import '../../converters/converters.dart';

part 'get_member_response.g.dart';

@JsonSerializable()
@GetMemberConverter()
class GetMemberResponse {
  const GetMemberResponse({this.items = const []});

  factory GetMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMemberResponseFromJson(json);

  final Iterable<IMemberEntity> items;

  Map<String, dynamic> toJson() => _$GetMemberResponseToJson(this);
}
