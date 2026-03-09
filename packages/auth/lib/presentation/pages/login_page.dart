import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service/mixin/cancelable_operations_mixin.dart';
import 'package:service/remote/api_scope_mixin.dart';
import 'package:service/remote/rest_client.io.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with CancelableOperationsMixin, ApiScopeMixin {
  testLogin() async {
    final RestClientProvider restClientProvider;
    var params = {"username": "COP", "password": "heelkindy@123"};
    final datas = await runApiScope(restClientProvider(), (client) async {
      final rawResponse = await client.post('/auth/mobile', data: params);
      return rawResponse.data;
    }).then((data) => data);

    print(datas);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 100,
            width: 300,
            color: Colors.green,
            child: Text('Login'),
          ),
        ),
      ),
    );
  }
}
