import 'package:flutter/foundation.dart';

@immutable
abstract class IUserEntity {
  const IUserEntity({
    this.id = '',
    this.username = '',
    this.nickname = '',
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final String username;
  final String nickname;
  final String role;
  final String createdAt;
  final String updatedAt;
}

class UserEntity extends IUserEntity {
  const UserEntity({
    super.id,
    super.username,
    super.nickname,
    super.role,
    super.createdAt,
    super.updatedAt,
  });
}
