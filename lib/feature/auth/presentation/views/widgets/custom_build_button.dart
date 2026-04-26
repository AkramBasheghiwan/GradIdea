import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dimens.dart';

class BuildLoginButton extends StatelessWidget {
  final bool isLoadig;
  final VoidCallback? onPressed;
  final String nameTextButton;

  final Color shodowColor;
  final Color? backgroundColor;
  const BuildLoginButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.nameTextButton,
    required this.isLoadig,
    required this.shodowColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.mainButtonRadius.r),
        ),
        elevation: 5,
        shadowColor: shodowColor,
      ),
      child: isLoadig
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                backgroundColor: AppColor.white,
              ),
            )
          : Text(nameTextButton, style: AppTextStyle.mainButtonText),
    ).animate().scale(delay: 600.ms, curve: Curves.easeOutBack);
  }
}
