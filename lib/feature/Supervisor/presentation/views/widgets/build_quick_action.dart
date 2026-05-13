import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:iconsax/iconsax.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class BuildQuickAction extends StatelessWidget {
  const BuildQuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionCard(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.reviewProposal);
          },
          title: "مراجعة المقترحات",
          subtitle: "عرض واتخاذ القرار",
          icon: Iconsax.note_favorite,
        ),

        SizedBox(height: 12.h),

        const _ActionCard(
          title: "مشاريعي",
          subtitle: "المشاريع التي أشرف عليها",
          icon: Iconsax.folder_open,
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primaryColor),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.bold(14)),
                  Text(
                    subtitle,
                    style: AppTextStyle.medium(12, color: AppColor.grey),
                  ),
                ],
              ),
            ),

            const Icon(Iconsax.arrow_left_2, color: AppColor.primaryColor),
          ],
        ),
      ),
    );
  }
}
