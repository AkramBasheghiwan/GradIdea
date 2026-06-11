import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    required this.confirmText,
    this.cancelText = "إلغاء",
    this.onConfirm,
    this.icon,
    this.confirmColor = Colors.red,
  });

  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final IconData? icon;
  final Color confirmColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: confirmColor.withValues(alpha: .1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: confirmColor, size: 30.sp),
              ),

            SizedBox(height: 18.h),

            Text(title, style: AppTextStyle.bold(20)),

            SizedBox(height: 8.h),

            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium(13, color: AppColor.grey),
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(cancelText),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor,
                    ),
                    child: Text(
                      confirmText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
