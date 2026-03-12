import 'package:service/service.dart';

abstract class IAuthLoginParam implements IParam {
  const IAuthLoginParam({this.username = '', this.password = ''});

  final String username;
  final String password;
}
