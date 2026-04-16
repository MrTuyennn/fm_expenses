import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member/member.dart';
import 'package:member/presentation/widgets/item_member.dart';
import 'package:theme/theme.dart';

@RoutePage()
class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(AppDimens.lg),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: appColors.gray[300]!)),
            ),
            child: Text(
              'Thành viên',
              style: appTextTheme.bodyEmphasized.copyWith(color: appColors.green[700]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.lg),
              child: BlocBuilder<MemberBloc, MemberState>(
                builder: (context, state) {
                  // if (state.memberType == MemberType.loading) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  // if (state.memberType == MemberType.error) {
                  //   return const Center(child: Text('Error'));
                  // }
                  // final lsMember = state.lsMember.toList();
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: AppDimens.md);
                    },
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ItemMember();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
