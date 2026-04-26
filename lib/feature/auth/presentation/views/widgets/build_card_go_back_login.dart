import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

import '../../../../../core/utils/app_text_style.dart';

class BuildCardGoBackLogin extends StatelessWidget {
  const BuildCardGoBackLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
        backgroundColor: AppColor.background,
        minimumSize: const Size(double.infinity, 50), // عرض كامل وارتفاع مناسب
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'الرجوع لتسجيل الدخول',
        style: AppTextStyle.skipButton.copyWith(color: Colors.indigoAccent),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
