import 'package:json_annotation/json_annotation.dart';
import 'package:member/data/dtos/get_member_dto.dart';
import 'package:member/domain/entities/entities.dart';

final class GetMemberConverter
    extends JsonConverter<IMemberEntity, Map<String, dynamic>> {
  const GetMemberConverter();
  @override
  IMemberEntity fromJson(Map<String, dynamic> json) {
    return GetMemberDto.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(IMemberEntity object) {
    return GetMemberDto(
      id: object.id,
      username: object.username,
      nickname: object.nickname,
      role: object.role,
      createdAt: object.createdAt,
      updatedAt: object.updatedAt,
    ).toJson();
  }
}
