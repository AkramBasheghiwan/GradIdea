import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/widgets/build_app_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class HorizontalActionCard extends StatelessWidget {
  const HorizontalActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.chip,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String chip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(18.w),
      hasBorder: true,
      child: Row(
        children: [
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -8,
                  left: -8,
                  child: Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Icon(icon, size: 30.sp, color: AppColor.primaryColor),
                ),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(title, style: AppTextStyle.bold(16))),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        chip,
                        style: AppTextStyle.bold(
                          11,
                          color: AppColor.primaryColor.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Text(subtitle, style: AppTextStyle.medium(13)),

                SizedBox(height: 12.h),

                Container(
                  width: 46.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryColor.withValues(alpha: 0.08),
                  AppColor.secondaryColor.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Iconsax.arrow_left_2,
              size: 18.sp,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 450.ms).slideX(begin: .12);
  }
}
