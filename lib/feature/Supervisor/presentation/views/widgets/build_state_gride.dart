import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class BuildStateGride extends StatelessWidget {
  const BuildStateGride({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.1,
      children: const [
        _StatCard("بانتظار", "12", Iconsax.clock),
        _StatCard("تم القبول", "8", Iconsax.tick_circle),
        _StatCard("مرفوضة", "3", Iconsax.close_circle),
        _StatCard("مقترحات", "6", Iconsax.folder),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.title, this.value, this.icon);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.primaryColor),

          SizedBox(height: 12.h),

          Text(value, style: AppTextStyle.bold(22)),

          Text(title, style: AppTextStyle.medium(12, color: AppColor.grey)),
        ],
      ),
    );
  }
}
