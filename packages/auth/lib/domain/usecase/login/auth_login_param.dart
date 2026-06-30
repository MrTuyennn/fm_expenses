import 'package:service/service.dart';

abstract class IAuthLoginParam implements IParam {
  const IAuthLoginParam({this.login = '', this.password = ''});

  final String login;
  final String password;
}
