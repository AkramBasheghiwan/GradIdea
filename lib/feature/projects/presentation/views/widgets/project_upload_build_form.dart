import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBuildForm extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const ProjectUploadBuildForm({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondaryColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColor.primaryColor, size: 22.r),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTextStyle.titleLarge18NormalStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 0.5),
          ...children,
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }
}
