import 'package:auth/domain/usecase/login/auth_login_param.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_param.g.dart';

@JsonSerializable(createFactory: false)
class AuthLoginParam extends IAuthLoginParam {
  const AuthLoginParam({required super.login, required super.password});

  @override
  Map<String, dynamic> toJson() => _$AuthLoginParamToJson(this);
}
