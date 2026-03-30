import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:providers/user/domain/entities/entities.dart';

import '../converters/converters.dart';

part 'list_user_dto.g.dart';

@JsonSerializable()
@UserConverter()
class ListUserDto {
  const ListUserDto({this.items = const []});

  factory ListUserDto.fromJson(Map<String, dynamic> json) =>
      _$ListUserDtoFromJson(json);

  final Iterable<IUserEntity> items;

  Map<String, dynamic> toJson() => _$ListUserDtoToJson(this);
}
