import 'package:flutter/material.dart';
import 'auth_data_entities.dart';

@immutable
class IAuthEntities {
  const IAuthEntities({
    this.success = false,
    this.data = const AuthDataEntities(),
  });

  final bool success;
  final IAuthDataEntities data;
}

class AuthEntities extends IAuthEntities {
  const AuthEntities({super.success, super.data});
}
