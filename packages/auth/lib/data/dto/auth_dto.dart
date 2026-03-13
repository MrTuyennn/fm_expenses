import 'package:auth/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/converters.dart';

part 'auth_dto.g.dart';

extension AuthDtoX on AuthDto {
  IAuthEntities toEntity() {
    return AuthEntities(success: success, data: data);
  }
}

@JsonSerializable()
@AuthDataCoverter()
class AuthDto {
  const AuthDto({this.success = false, this.data = const AuthDataEntities()});

  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);

  final bool success;
  final IAuthDataEntities data;

  Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}
