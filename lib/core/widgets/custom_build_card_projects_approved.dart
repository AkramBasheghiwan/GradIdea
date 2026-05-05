import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomBuildCardProjectsApproved extends StatelessWidget {
  const CustomBuildCardProjectsApproved({
    super.key,
    required this.onTap,
    required this.project,
  });
  final VoidCallback onTap;
  final dynamic project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 18.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: .06),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.auto_awesome, color: Colors.white, size: 26.sp),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: AppTextStyle.bold(17),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.medium(13, color: AppColor.grey),
                  ),

                  SizedBox(height: 14.h),

                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16.sp,
                        color: AppColor.outline,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          project.supervisor,
                          style: AppTextStyle.medium(
                            12,
                            color: AppColor.outline,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Icon(
                        Icons.groups_2_outlined,
                        size: 16.sp,
                        color: AppColor.outline,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "${project.students.length}",
                        style: AppTextStyle.medium(12, color: AppColor.outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryContainer.withValues(alpha: .25),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    "دفعة ${project.year}",
                    style: AppTextStyle.bold(11, color: AppColor.primaryColor),
                  ),
                ),

                SizedBox(height: 18.h),

                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: AppColor.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
