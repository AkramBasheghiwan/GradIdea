import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class ValidationTipsCard extends StatelessWidget {
  const ValidationTipsCard({super.key});

  Widget _tip(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.tick_circle, color: AppColor.primaryColor, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.medium(13, color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.primaryColor.withValues(alpha: .08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.lamp_on, color: AppColor.primaryColor, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                "نصائح لنتيجة أدق",
                style: AppTextStyle.bold(15, color: AppColor.primaryColor),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          _tip("اشرح الفكرة الأساسية بوضوح"),
          _tip("اذكر التقنية أو المجال المستخدم"),
          _tip("وضح القيمة الجديدة التي سيقدمها المشروع"),
        ],
      ),
    );
  }
}
