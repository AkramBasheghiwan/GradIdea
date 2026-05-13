import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class DepartmentActionCard extends StatelessWidget {
  const DepartmentActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: .04),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: AppColor.outline.withValues(alpha: .08)),
        ),
        child: Row(
          children: [
            /// icon
            Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(icon, color: Colors.white, size: 26.sp),
            ),

            SizedBox(width: 14.w),

            /// text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.bold(16)),

                  SizedBox(height: 6.h),

                  Text(
                    subtitle,
                    style: AppTextStyle.medium(12, color: AppColor.grey),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            /// arrow
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
