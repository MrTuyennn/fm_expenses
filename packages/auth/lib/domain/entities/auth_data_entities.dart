import 'package:flutter/material.dart';

@immutable
abstract class IAuthDataEntities {
  const IAuthDataEntities({this.accessToken = '', this.refreshToken = ''});

  final String accessToken;
  final String refreshToken;
}

class AuthDataEntities extends IAuthDataEntities {
  const AuthDataEntities({super.accessToken, super.refreshToken});
}
