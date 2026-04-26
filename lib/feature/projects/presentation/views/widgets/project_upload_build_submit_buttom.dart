import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBuildSubmitButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  const ProjectUploadBuildSubmitButtom({
    required this.isLoading,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        elevation: 8,
        minimumSize: Size(double.infinity, 56.h),
        shadowColor: AppColor.primaryColor.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColor.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch_rounded, color: Colors.white),
                SizedBox(width: 12.w),
                Text(
                  AppStrings.submitProject,
                  style: AppTextStyle.mainButtonText,
                ),
              ],
            ),
    ).animate().scale(curve: Curves.easeOutBack);
  }
}
