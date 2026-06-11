import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildHeroCard extends StatelessWidget {
  final String title;
  final String description;
  final String badgeText;

  final IconData icon;

  final Gradient gradient;

  const CustomBuildHeroCard({
    super.key,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Row(
        children: [
          /// Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
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
                        color: Colors.white.withValues(alpha: .16),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .18),
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 250.ms)
                    .scale(begin: const Offset(.9, .9)),
              ],
            ).animate().fadeIn(duration: 500.ms).slideX(begin: -.05),
          ),

          SizedBox(width: 12.w),

          /// Right Icon
          Container(
            width: 74.w,
            height: 74.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 34.sp, color: Colors.white),
          ).animate(delay: 150.ms).fadeIn().scale(begin: const Offset(.8, .8)),
        ],
      ),
    );
  }
}
