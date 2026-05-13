import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColor.primaryColor.withValues(alpha: .1),
          child: const Icon(Iconsax.user, color: AppColor.primaryColor),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("مرحباً دكتور 👋", style: AppTextStyle.bold(16)),
              Text(
                "إدارة ومراجعة المقترحات بسهولة",
                style: AppTextStyle.medium(12, color: AppColor.grey),
              ),
            ],
          ),
        ),

        const Icon(Iconsax.notification, color: AppColor.primaryColor),
      ],
    );
  }
}
