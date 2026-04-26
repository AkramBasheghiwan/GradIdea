import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/onboarding/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBuildText extends StatelessWidget {
  final int currentIndex;
  const OnboardingBuildText({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(currentIndex),
      children: <Widget>[
        Text(
          items[currentIndex].title,
          style: AppTextStyle.headline24BoldStyle,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: AppDimens.p16.h),
        Text(
          items[currentIndex].body,
          style: AppTextStyle.subHeadline16NormalStyle,
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}
