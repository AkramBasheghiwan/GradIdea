import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class ValidationLoadingWidget extends StatelessWidget {
  const ValidationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 34.w,
            height: 34.w,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColor.primaryColor,
            ),
          ),

          SizedBox(height: 18.h),

          Icon(Iconsax.cpu, color: AppColor.primaryColor, size: 32.sp),

          SizedBox(height: 14.h),

          Text("جاري تحليل فكرتك...", style: AppTextStyle.bold(16)),

          SizedBox(height: 8.h),

          Text(
            "نقارنها الآن مع المشاريع السابقة باستخدام الذكاء الاصطناعي",
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(13, color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}
