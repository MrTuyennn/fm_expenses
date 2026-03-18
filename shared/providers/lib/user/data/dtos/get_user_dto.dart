import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:providers/user/domain/entities/entities.dart';

part 'get_user_dto.g.dart';

extension GetUserDtoX on GetUserDto {
  IUserEntity toEntity() {
    return UserEntity(
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
class GetUserDto {
  const GetUserDto({
    this.id = '',
    this.username = '',
    this.nickname = '',
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory GetUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDtoFromJson(json);

  final String id;
  final String username;
  final String nickname;
  final String role;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$GetUserDtoToJson(this);
}
