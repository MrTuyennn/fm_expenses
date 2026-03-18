class IMemberEntity {
  const IMemberEntity({
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

class MemberEntity extends IMemberEntity {
  const MemberEntity({
    super.id,
    super.username,
    super.nickname,
    super.role,
    super.createdAt,
    super.updatedAt,
  });
}
