import 'package:flutter/material.dart';

import 'auth_user_entities.dart';

@immutable
abstract class IAuthDataEntities {
  const IAuthDataEntities({
    this.accessToken = '',
    this.refreshToken = '',
    this.user = const AuthUserEntities(),
  });

  final String accessToken;
  final String refreshToken;
  final IAuthUserEntities user;
}

class AuthDataEntities extends IAuthDataEntities {
  const AuthDataEntities({super.accessToken, super.refreshToken, super.user});
}
