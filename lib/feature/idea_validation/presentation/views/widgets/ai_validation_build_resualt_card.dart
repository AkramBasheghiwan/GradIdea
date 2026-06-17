import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 42.sp, color: color),
          ),

          SizedBox(height: 18.h),

          Text(title, style: AppTextStyle.bold(22)),

          SizedBox(height: 10.h),

          Text(value, style: AppTextStyle.extraBold(34, color: color)),

          SizedBox(height: 12.h),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
