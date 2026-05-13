import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class BuildHeroCard extends StatelessWidget {
  const BuildHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.primaryColor, AppColor.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "لديك 5 مقترحات بانتظار المراجعة",
                  style: AppTextStyle.bold(16, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                Text(
                  "ابدأ الآن بمراجعتها واتخاذ القرار",
                  style: AppTextStyle.medium(12, color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(Iconsax.note_favorite, color: Colors.white, size: 32.sp),
        ],
      ),
    );
  }
}
