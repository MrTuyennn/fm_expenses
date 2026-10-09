import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:providers/user/domain/entities/entities.dart';

part 'get_user_dto.g.dart';

extension GetUserDtoX on GetUserDto {
  IUserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      createdAt: DateTime.tryParse(createdAt),
      updatedAt: DateTime.tryParse(updatedAt),
    );
  }
}

@JsonSerializable()
class GetUserDto {
  const GetUserDto({
    this.id = '',
    this.email = '',
    @JsonKey(name: 'full_name') this.fullName = '',
    @JsonKey(name: 'created_at') this.createdAt = '',
    @JsonKey(name: 'updated_at') this.updatedAt = '',
  });

  factory GetUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDtoFromJson(json);

  final String id;
  final String email;
  final String fullName;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$GetUserDtoToJson(this);
}
