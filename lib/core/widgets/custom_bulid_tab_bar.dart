import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBulidTabBar extends StatelessWidget {
  final List<Tab> tap;
  const CustomBulidTabBar({required this.tap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Container(
        padding: EdgeInsets.all(3.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.r30.r),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColor.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimens.r30.r),
          ),
          dividerColor: AppColor.transparent,
          labelColor: AppColor.activeColor,
          unselectedLabelColor: AppColor.textSecondary,
          isScrollable: true,

          tabs: tap,
        ),
      ).animate().slideX(begin: 1, end: 0),
    );
  }
}
