import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member/domain/entities/entities.dart';

part 'get_member_dto.g.dart';

extension GetMemberDtoX on GetMemberDto {
  IMemberEntity toEntity() {
    return MemberEntity(
      id: id,
      username: username,
      nickname: nickname,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@JsonSerializable()
class GetMemberDto {
  const GetMemberDto({
    this.id = '',
    this.username = '',
    this.nickname = '',
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory GetMemberDto.fromJson(Map<String, dynamic> json) =>
      _$GetMemberDtoFromJson(json);

  final String id;
  final String username;
  final String nickname;
  final String role;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$GetMemberDtoToJson(this);
}
