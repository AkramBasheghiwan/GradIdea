import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

class CustomBuildContainerIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed;
  const CustomBuildContainerIcon({
    super.key,
    required this.icon,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColor.activeBgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentBlue.withValues(alpha: 0.40),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 30, color: color ?? AppColor.primaryColor),
      ),
    );
  }
}
