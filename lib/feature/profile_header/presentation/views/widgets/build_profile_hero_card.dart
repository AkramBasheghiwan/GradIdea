import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.secondaryColor, AppColor.primaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.28),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar(),

              SizedBox(width: 18.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "أحمد محمد علي",
                      style: AppTextStyle.bold(22, color: Colors.white),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "ahmed@university.edu",
                      style: AppTextStyle.medium(13, color: Colors.white70),
                    ),
                    SizedBox(height: 14.h),
                    _buildMajorChip(),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(
                icon: Iconsax.calendar,
                title: "عضو منذ",
                value: "مارس 2024",
              ),
              _infoItem(
                icon: Iconsax.profile_2user,
                title: "الملف",
                value: "مكتمل 85%",
              ),
              _progressCircle(),
            ],
          ),

          SizedBox(height: 22.h),

          Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Iconsax.edit, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    "تعديل الملف الشخصي",
                    style: AppTextStyle.bold(15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: .15);
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 110.w,
          height: 110.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 3,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.user, size: 48.sp, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.camera,
              size: 18.sp,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMajorChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Iconsax.teacher, color: Colors.white, size: 18),
          SizedBox(width: 8.w),
          Text(
            "علوم الحاسب",
            style: AppTextStyle.bold(13, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70),
        SizedBox(height: 6.h),
        Text(title, style: AppTextStyle.medium(12, color: Colors.white70)),
        SizedBox(height: 4.h),
        Text(value, style: AppTextStyle.bold(13, color: Colors.white)),
      ],
    );
  }

  Widget _progressCircle() {
    return SizedBox(
      width: 54.w,
      height: 54.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CircularProgressIndicator(
            value: .85,
            strokeWidth: 5,
            color: Colors.white,
            backgroundColor: Colors.white24,
          ),
          Text("85%", style: AppTextStyle.bold(10, color: Colors.white)),
        ],
      ),
    );
  }
}
