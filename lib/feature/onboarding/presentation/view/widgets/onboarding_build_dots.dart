import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBuildDots extends StatelessWidget {
  final int currentIndex;
  final int index;
  const OnboardingBuildDots({
    required this.currentIndex,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: AppDimens.p8.w),
      height: AppDimens.dotSize.h,
      width: isActive ? AppDimens.activeDotWidth.w : AppDimens.dotSize.w,
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryColor : AppColor.inactiveDot,
        borderRadius: BorderRadius.circular(AppDimens.r8.r),
      ),
    );
  }
}
