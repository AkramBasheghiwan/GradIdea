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
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.onSurface.withValues(alpha:  0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Blue side border
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 4.w,
            child: Container(color: AppColor.primaryColor),
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
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.pending,
                            size: 14.sp,
                            color: AppColor.onTertiaryFixed,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppStrings.pendingStatus,
                            style: AppTextStyle.badgeText,
                          ),
                        ],
                      ),
                    ),
                    Text(id, style: AppTextStyle.labelSmall),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(title, style: AppTextStyle.titleMedium),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: AppTextStyle.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16.h),
                Divider(color: AppColor.outlineVariant.withValues(alpha:  0.2)),
                Text(AppStrings.teamWork, style: AppTextStyle.labelSmall),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  children: team
                      .map(
                        (name) => Chip(
                          label: Text(
                            name,
                            style: AppTextStyle.bodyMedium.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          backgroundColor: AppColor.secondaryContainer
                              .withOpacity(0.1),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColor.primaryGradient,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.viewDetails,
                          style: AppTextStyle.buttonText,
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ],
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
