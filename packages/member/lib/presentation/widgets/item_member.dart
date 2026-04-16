import 'package:flutter/material.dart';
import 'package:member/domain/entities/member_entity.dart';
import 'package:theme/theme.dart';

class ItemMember extends StatelessWidget {
  const ItemMember({super.key, this.member});

  final IMemberEntity? member;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;
    return Container(
      padding: EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.slg),
        border: Border.all(width: 0.5, color: appColors.gray[300]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppDimens.xl,
            backgroundColor: appColors.green[700],
            child: Text(
              "dev".substring(0, 1).toUpperCase(),
              style: appTextTheme.bodyEmphasized.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: AppDimens.md),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text("dev", style: appTextTheme.callout),
              const SizedBox(height: AppDimens.md),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.slg),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.lg),
                      color: appColors.gray[100]!,
                    ),
                    child: Text("dev"),
                  ),
                  const SizedBox(width: AppDimens.md),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.lg),
                      color: appColors.green[200]!,
                    ),
                    child: Text("USER"),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.md),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: AppDimens.slg, color: appColors.gray[500]),
                  const SizedBox(width: AppDimens.sm),
                  Text(
                    "Ngày tạo: 16/01/2026",
                    style: appTextTheme.caption1.copyWith(color: appColors.gray[500]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
