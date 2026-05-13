import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class DepartmentHeroCard extends StatelessWidget {
  const DepartmentHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColor.primaryColor, AppColor.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "قسم تقنية المعلومات",
                  style: AppTextStyle.bold(22, color: Colors.white),
                ),

                SizedBox(height: 10.h),

                Text(
                  "إدارة المشاريع الأكاديمية ومتابعة المقترحات واعتماد المشاريع الخاصة بالقسم.",
                  style: AppTextStyle.medium(
                    13,
                    color: Colors.white.withValues(alpha: .90),
                  ),
                ),

                SizedBox(height: 18.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .22),
                    ),
                  ),
                  child: Text(
                    "لوحة الإدارة",
                    style: AppTextStyle.bold(11, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          Container(
            width: 74.w,
            height: 74.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .15),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.building_3, size: 34.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
