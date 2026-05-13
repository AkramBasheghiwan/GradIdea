import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/Student_home/presentation/views/widgets/build_app_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class BuildListTitleCard extends StatelessWidget {
  const BuildListTitleCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 22.sp),
          ),

          SizedBox(width: 14.w),

          Expanded(child: Text(title, style: AppTextStyle.bold(14))),

          Icon(Iconsax.arrow_left_2, size: 18.sp, color: AppColor.grey),
        ],
      ),
    );
  }
}
