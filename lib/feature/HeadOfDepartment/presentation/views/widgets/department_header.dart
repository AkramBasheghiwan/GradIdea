import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class DepartmentHeader extends StatelessWidget {
  const DepartmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: .18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Iconsax.teacher, color: Colors.white, size: 26.sp),
        ),

        SizedBox(width: 14.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("مرحبًا، رئيس القسم", style: AppTextStyle.bold(20)),

              SizedBox(height: 4.h),

              Text(
                "متابعة واعتماد مشاريع التخرج",
                style: AppTextStyle.medium(13, color: AppColor.grey),
              ),
            ],
          ),
        ),

        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Iconsax.notification,
            color: AppColor.primaryColor,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}
