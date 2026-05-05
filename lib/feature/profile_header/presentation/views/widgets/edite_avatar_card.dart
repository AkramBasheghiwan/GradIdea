import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class EditAvatarCard extends StatelessWidget {
  const EditAvatarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 26.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.secondaryColor, AppColor.primaryColor],
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white54, width: 3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Iconsax.user, size: 56.sp, color: Colors.white),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.camera,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.gallery_edit, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  "تغيير الصورة",
                  style: AppTextStyle.bold(14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: .12);
  }
}
