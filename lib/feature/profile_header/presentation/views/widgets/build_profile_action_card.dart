import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/Student_home/presentation/views/widgets/build_app_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class ProfileActionCard extends StatelessWidget {
  const ProfileActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.count,
    required this.color,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String count;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      hasBorder: true,
      padding: EdgeInsets.all(18.w),
      child: Row(
        children: [
          Container(
            width: 74.w,
            height: 74.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Icon(icon, size: 30.sp, color: AppColor.primaryColor),
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.bold(16)),
                SizedBox(height: 6.h),
                Text(subtitle, style: AppTextStyle.medium(13)),
              ],
            ),
          ),

          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Text(
                  count,
                  style: AppTextStyle.bold(12, color: AppColor.primaryColor),
                ),
              ),
              SizedBox(height: 10.h),
              Icon(
                Iconsax.arrow_left_2,
                size: 18.sp,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(duration: 450.ms).slideX(begin: .1);
  }
}
