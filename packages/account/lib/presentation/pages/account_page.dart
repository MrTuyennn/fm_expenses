import 'package:auto_route/auto_route.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providers/providers.dart';
import 'package:providers/user/domain/entities/entities.dart';
import 'package:theme/theme.dart';
import 'package:utils/extensions/date_time_extension.dart';

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
              style: appTextTheme.bodyEmphasized.copyWith(color: appColors.green[700]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimens.slg),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimens.slg)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(AppDimens.slg)),
                  border: Border.all(color: appColors.gray[300]!),
                ),
                child: BlocSelector<UserBloc, UserState, IUserEntity>(
                  selector: (state) => state.user,
                  builder: (context, user) {
                    return Column(
                      children: [
                        ColoredBox(
                          color: appColors.blue,
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
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username,
                                      style: appTextTheme.bodyEmphasized.copyWith(
                                        color: appColors.white,
                                      ),
                                    ),
                                    Text(
                                      user.nickname,
                                      style: appTextTheme.body.copyWith(color: appColors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(AppDimens.lg),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person_outline),
                                  const SizedBox(width: AppDimens.sm),
                                  Text("Thông tin cơ bản", style: appTextTheme.bodyEmphasized),
                                ],
                              ),
                              const SizedBox(height: AppDimens.lg),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tên đăng nhập',
                                          style: appTextTheme.subheadline.copyWith(
                                            color: appColors.gray[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(user.username, style: appTextTheme.bodyEmphasized),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tên hiển thị',
                                          style: appTextTheme.subheadline.copyWith(
                                            color: appColors.gray[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(user.username, style: appTextTheme.bodyEmphasized),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimens.xxl),

                              Row(
                                children: [
                                  Icon(Icons.shield_outlined),
                                  const SizedBox(width: AppDimens.sm),
                                  Text("Vai trò và quyền hạn", style: appTextTheme.bodyEmphasized),
                                ],
                              ),
                              const SizedBox(height: AppDimens.lg),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.slg,
                                      vertical: AppDimens.sm,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: appColors.green[100],
                                    ),
                                    child: Text(
                                      "Người dùng",
                                      style: appTextTheme.subheadline.copyWith(
                                        color: appColors.green[700],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppDimens.md),
                                  Text("(${user.role})"),
                                ],
                              ),
                              const SizedBox(height: AppDimens.xxl),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  const SizedBox(width: AppDimens.sm),
                                  Text("Thông tin tài khoản", style: appTextTheme.bodyEmphasized),
                                ],
                              ),
                              const SizedBox(height: AppDimens.lg),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ngày tạo',
                                          style: appTextTheme.subheadline.copyWith(
                                            color: appColors.gray[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          DateTime.parse(user.createdAt).formatDate(),
                                          style: appTextTheme.subheadline,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cập nhật lần cuối',
                                          style: appTextTheme.subheadline.copyWith(
                                            color: appColors.gray[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          DateTime.parse(user.updatedAt).formatDate(),
                                          style: appTextTheme.subheadline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimens.lg),
                              Divider(color: appColors.gray[200]),
                              const SizedBox(height: AppDimens.lg),
                              ActionButton(
                                label: "Đăng xuất",
                                onPressed: () {},
                                backgroundColor: appColors.red,
                                icon: Icon(Icons.logout),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
