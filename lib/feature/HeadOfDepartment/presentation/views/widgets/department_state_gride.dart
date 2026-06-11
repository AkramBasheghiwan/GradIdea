import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardStatModel {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardStatModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class CustomBuildStateGrid extends StatelessWidget {
  final List<DashboardStatModel> items;

  const CustomBuildStateGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14.h,
        crossAxisSpacing: 14.w,
        childAspectRatio: 1.02,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return DashboardStatCard(item: item)
            .animate(delay: (index * 120).ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: .12);
      },
    );
  }
}

class DashboardStatCard extends StatelessWidget {
  final DashboardStatModel item;

  const DashboardStatCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),

        border: Border.all(color: Colors.grey.withValues(alpha: .06)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .035),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Icon
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Icon(item.icon, color: item.color, size: 22.sp),
          ),

          const Spacer(),

          /// Value
          Text(
            item.value,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff111827),
            ),
          ),

          SizedBox(height: 4.h),

          /// Title
          Text(
            item.title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
