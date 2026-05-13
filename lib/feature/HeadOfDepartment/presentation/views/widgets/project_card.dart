import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class ProjectCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final List<String> team;

  const ProjectCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.onSurface.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // الخط الجانبي الملون
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 6.w,
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.tertiaryFixed,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 14.sp,
                            color: AppColor.onTertiaryFixed,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            AppStrings.statusPending,
                            style: AppTextStyle.medium(14),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      id,
                      style: TextStyle(
                        color: AppColor.outline,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(title, style: AppTextStyle.bold(18)),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: AppTextStyle.bold(16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16.h),
                Divider(color: AppColor.outline.withValues(alpha: 0.1)),
                SizedBox(height: 8.h),
                Text('اعضاء الفريق', style: AppTextStyle.medium(16)),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  children: team
                      .map(
                        (member) => Chip(
                          backgroundColor: AppColor.secondaryContainer
                              .withValues(alpha: 0.2),
                          label: Text(
                            member,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF004666),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_left, color: AppColor.white),
                    label: const Text(
                      AppStrings.viewDetails,
                      style: TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
