import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/main.dart';
import 'package:theme/theme.dart';
import 'package:providers/providers.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColor = theme.appColors;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.userType == UserType.success) {
          context.router.replace(const MainRoute());
        } else if (state.userType == UserType.error) {
          context.router.replace(const LoginRoute());
        }
      },
      child: Container(color: appColor.green[700]),
    );
  }
}
