import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providers/providers.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:theme/theme.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;

    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(AppDimens.lg),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: appColors.gray[300]!)),
            ),
            child: Text(
              'Tài khoản',
              style: appTextTheme.bodyEmphasized.copyWith(
                color: appColors.green[700],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimens.slg),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimens.slg)),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: appColors.gray[300]!),
                ),
                child: Column(
                  children: [
                    BlocSelector<UserBloc, UserState, IUserEntity>(
                      selector: (state) => state.user,
                      builder: (context, user) {
                        return ColoredBox(
                          color: appColors.green[700]!,
                          child: Padding(
                            padding: EdgeInsets.all(AppDimens.slg),
                            child: Row(
                              spacing: AppDimens.slg,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.nickname,
                                      style: appTextTheme.bodyEmphasized
                                          .copyWith(color: appColors.white),
                                    ),
                                    Text(
                                      user.username,
                                      style: appTextTheme.body.copyWith(
                                        color: appColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
