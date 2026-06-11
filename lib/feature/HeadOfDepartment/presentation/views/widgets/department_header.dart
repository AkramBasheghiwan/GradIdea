import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildHeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final IconData actionIcon;

  final VoidCallback? onActionTap;

  final Gradient gradient;

  const CustomBuildHeaderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.actionIcon,
    required this.gradient,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Leading Icon
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26.sp),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -.15),

        SizedBox(width: 14.w),

        /// Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff111827),
                ),
              ),

              SizedBox(height: 4.h),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ).animate(delay: 100.ms).fadeIn(duration: 450.ms).slideY(begin: .2),
        ),

        /// Action Button
        GestureDetector(
              onTap: onActionTap,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.withValues(alpha: .08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  actionIcon,
                  color: const Color(0xff4F46E5),
                  size: 22.sp,
                ),
              ),
            )
            .animate(delay: 200.ms)
            .fadeIn(duration: 500.ms)
            .scale(begin: const Offset(.8, .8)),
      ],
    );
  }
}
