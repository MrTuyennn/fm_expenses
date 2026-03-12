import 'package:flutter/material.dart';

@immutable
abstract class IAuthUserEntities {
  const IAuthUserEntities({this.id = '', this.username = '', this.role = ''});

  final String id;
  final String username;
  final String role;
}

class AuthUserEntities extends IAuthUserEntities {
  const AuthUserEntities({super.id, super.username, super.role});
}
