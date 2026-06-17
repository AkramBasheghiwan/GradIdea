import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProjectUploadBuildSubmitButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEdit;
  final String buttonUploudText;
  final String buttonEditText;
  const ProjectUploadBuildSubmitButtom({
    required this.isLoading,
    required this.buttonEditText,
    this.onPressed,
    required this.isEdit,
    required this.buttonUploudText,
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
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEdit ? Iconsax.edit_2 : Iconsax.send_1,
                  color: AppColor.white,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  isEdit ? buttonEditText : buttonUploudText,
                  style: AppTextStyle.mainButtonText,
                ),
              ],
            ),
    ).animate().scale(curve: Curves.easeOutBack);
  }
}
