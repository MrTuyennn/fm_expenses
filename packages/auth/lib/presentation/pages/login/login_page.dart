import 'dart:convert';

import 'package:auth/data/usecase_params/auth_login_param.dart';
import 'package:auth/presentation/pages/login/bloc/auth_login_bloc.dart';
import 'package:auth/presentation/pages/login/bloc/auth_login_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:service/service.dart';
import 'package:theme/theme.dart';

import '../../components/input.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  Future<void> _testApi() async {
    setState(() => _loading = true);
    try {
      final IRestClient client = RestClient();
      var params = {"username": "ROT", "password": "rot@123"};
      String str = jsonEncode(params);
      final res = await client.post('/auth/login', str);
      print(res);
      final status = res?.statusCode;
      final data = res?.data;

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('-> status=$status, data=$data')));
    } catch (e, st) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('API error: $e')));
      // Optional: debug log
      // ignore: avoid_print
      print(st);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;
    final l10n = L10n.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimens.slg),
        child: Column(
          spacing: AppDimens.xxl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FM EXPENSES',
              style: appTextTheme.largeTitle.copyWith(
                color: appColors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Input(
              label: l10n?.txt_username ?? '',
              hintText: l10n?.txt_enter_username ?? '',
            ),
            Input(
              label: l10n?.txt_password ?? '',
              hintText: l10n?.txt_enter_password ?? '',
            ),
            ActionButton(
              isLoading: _loading,
              label: 'Đăng nhập',
              onPressed: () {
                context.read<AuthLoginBloc>().add(
                  AuthLogin(
                    params: AuthLoginParam(
                      username: 'ROT',
                      password: 'rot@123',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
