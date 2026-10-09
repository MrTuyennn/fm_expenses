import 'package:flutter/foundation.dart';

@immutable
abstract class IUserEntity {
  const IUserEntity({
    this.id = '',
    this.email = '',
    this.fullName = '',
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String fullName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class UserEntity extends IUserEntity {
  const UserEntity({
    super.id,
    super.email,
    super.fullName,
    super.createdAt,
    super.updatedAt,
  });
}
