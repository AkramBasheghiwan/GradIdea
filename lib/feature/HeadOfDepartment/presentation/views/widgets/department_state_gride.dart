import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class DepartmentStatsGrid extends StatelessWidget {
  const DepartmentStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14.h,
      crossAxisSpacing: 14.w,
      childAspectRatio: 1.0,
      children: const [
        _StatCard(
          title: "قيد النظر",
          value: "12",
          icon: Iconsax.timer_1,
          color: Color(0xffF59E0B),
        ),
        _StatCard(
          title: "معتمدة",
          value: "31",
          icon: Iconsax.tick_circle,
          color: Color(0xff10B981),
        ),
        _StatCard(
          title: "مرفوضة",
          value: "4",
          icon: Iconsax.close_circle,
          color: Color(0xffEF4444),
        ),
        _StatCard(
          title: "مقترحات",
          value: "18",
          icon: Iconsax.message_question,
          color: AppColor.primaryColor,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .05),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FittedBox(
        alignment: Alignment.centerRight,
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: 120.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: color, size: 22.sp),
              ),

              SizedBox(height: 12.h),

              Text(
                value,
                style: AppTextStyle.bold(24, color: AppColor.primaryColor),
              ),

              SizedBox(height: 2.h),

              Text(title, style: AppTextStyle.medium(12, color: AppColor.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
