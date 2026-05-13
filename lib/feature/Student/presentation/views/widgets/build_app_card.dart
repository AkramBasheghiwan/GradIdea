import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color = AppColor.white,
    this.radius,
    this.onTap,
    this.hasBorder = false,
  });

  final Widget child;
  final EdgeInsets? padding;
  final Color color;
  final double? radius;
  final VoidCallback? onTap;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? 30.r);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          padding: padding ?? EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: hasBorder
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.75),
                    width: 1.1,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: 0.05),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
              const BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
