import 'package:auth/data/usecase_params/auth_login_param.dart';
import 'package:auth/presentation/pages/login/bloc/auth_login_bloc.dart';
import 'package:auth/presentation/pages/login/bloc/auth_login_event.dart';
import 'package:auth/presentation/pages/login/bloc/auth_login_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:theme/theme.dart';

import '../../components/input.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final ValueNotifier<String?> _usernameError = ValueNotifier(null);
  final ValueNotifier<String?> _passwordError = ValueNotifier(null);

  bool _validate() {
    final l10n = L10n.of(context);
    _usernameError.value = _controllerUserName.text.isEmpty
        ? l10n?.txt_please_enter_username
        : null;
    _passwordError.value = _controllerPassword.text.isEmpty
        ? l10n?.txt_please_enter_password
        : null;

    return _usernameError.value == null && _passwordError.value == null;
  }

  @override
  void initState() {
    super.initState();
    _controllerUserName.addListener(() => _usernameError.value = null);
    _controllerPassword.addListener(() => _passwordError.value = null);
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    _controllerPassword.dispose();
    _usernameError.dispose();
    _passwordError.dispose();
    super.dispose();
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
            ValueListenableBuilder(
              valueListenable: _usernameError,
              builder: (_, error, __) => Input(
                controller: _controllerUserName,
                label: l10n?.txt_username ?? '',
                hintText: l10n?.txt_enter_username ?? '',
                errorText: error,
              ),
            ),

            ValueListenableBuilder(
              valueListenable: _passwordError,
              builder: (_, error, __) => Input(
                controller: _controllerPassword,
                label: l10n?.txt_password ?? '',
                hintText: l10n?.txt_enter_password ?? '',
                errorText: error,
              ),
            ),
            BlocSelector<AuthLoginBloc, AuthLoginState, AuthLoginType>(
              selector: (state) {
                return state.loginType;
              },
              builder: (context, state) {
                return ActionButton(
                  isLoading: state == AuthLoginType.loading,
                  label: l10n?.txt_login ?? '',
                  onPressed: () {
                    if (!_validate()) return;

                    context.read<AuthLoginBloc>().add(
                      AuthLogin(
                        params: AuthLoginParam(
                          username: _controllerUserName.text,
                          password: _controllerPassword.text,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
