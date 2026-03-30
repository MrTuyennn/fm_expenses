import 'package:json_annotation/json_annotation.dart';
import 'package:providers/user/data/dtos/get_user_dto.dart';
import 'package:providers/user/domain/entities/entities.dart';

final class UserConverter
    extends JsonConverter<IUserEntity, Map<String, dynamic>> {
  const UserConverter();

  @override
  IUserEntity fromJson(Map<String, dynamic> json) {
    return GetUserDto.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(IUserEntity object) {
    return GetUserDto(
      id: object.id,
      username: object.username,
      nickname: object.nickname,
      role: object.role,
      createdAt: object.createdAt,
      updatedAt: object.updatedAt,
    ).toJson();
  }
}
