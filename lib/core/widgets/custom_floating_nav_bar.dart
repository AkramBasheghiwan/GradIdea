import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final Color? color;
  final List<Widget> childern;
  const CustomFloatingNavBar({super.key, required this.childern, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      // جعل الشريط عائماً عن طريق المسافات
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color ?? AppColor.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childern,
      ),
    );
  }
}
