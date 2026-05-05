import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomBuildProjectErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback? onTape;
  const CustomBuildProjectErrorCard({
    super.key,
    required this.message,
    this.onTape,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 95.h,
              width: 95.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withValues(alpha: 0.08),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 42.sp,
                color: Colors.red.shade400,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              "حدث خطأ",
              style: AppTextStyle.bold(24, color: AppColor.textPrimary),
            ),

            SizedBox(height: 10.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium(
                14,
                color: AppColor.grey,
              ).copyWith(height: 1.7),
            ),

            SizedBox(height: 28.h),

            InkWell(
              borderRadius: BorderRadius.circular(18.r),
              onTap: onTape,
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withValues(alpha: .25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "إعادة المحاولة",
                      style: AppTextStyle.bold(14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
