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
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    UserBloc userBloc = context.read<UserBloc>();
    Future<bool> isAuth() async {
      if (userBloc.state.userType == UserType.success) return true;
      if (userBloc.state.userType == UserType.error) return false;

      // Nếu đang loading thì mới chờ stream
      final state = await userBloc.stream.firstWhere(
        (s) => s.userType == UserType.success || s.userType == UserType.error,
      );

      return state.userType == UserType.success;
    }

    final authenticated = await isAuth();

    if (authenticated && mounted) {
      context.router.replace(const MainRoute());
    } else if (mounted) {
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColor = theme.appColors;
    return Container(color: appColor.green[700]);
  }
}
