import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String description;
  final String linkText;
  final String imageUrl;
  final Color imageBgColor;
  final double rotation;

  const ActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.linkText,
    required this.imageUrl,
    required this.imageBgColor,
    this.rotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentBlue.withValues(alpha: 0.40),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade50),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppTextStyle.bold(16)),
                SizedBox(height: 4.h),
                Text(description, style: AppTextStyle.bodyMedium),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(linkText, style: AppTextStyle.bold(16)),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_back,
                      color: AppColor.primaryColor,
                      size: 16.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            height: 90.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: rotation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: imageBgColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
                Image.network(
                  imageUrl,
                  width: 75.w,
                  height: 75.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
