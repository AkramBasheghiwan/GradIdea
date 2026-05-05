import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomBuildCardStatusRejected extends StatelessWidget {
  const CustomBuildCardStatusRejected({
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
              color: AppColor.primaryColor.withValues(alpha: .05),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(color: Colors.red.withValues(alpha: .08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            Row(
              children: [
                Container(
                  width: 62.w,
                  height: 62.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFEF2F2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 28.sp,
                  ),
                ),

                SizedBox(width: 14.w),

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

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffFEF2F2),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Text(
                          "مرفوض",
                          style: AppTextStyle.bold(11, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryContainer.withValues(alpha: .20),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    "دفعة ${project.year}",
                    style: AppTextStyle.bold(11, color: AppColor.primaryColor),
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            /// rejection reason
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xffFEF2F2),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xffFECACA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.red,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "سبب الرفض",
                        style: AppTextStyle.bold(13, color: Colors.red),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    project.rejectionReason ?? "لم يتم تحديد سبب الرفض",
                    style: AppTextStyle.medium(
                      13,
                      color: const Color(0xff7F1D1D),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// footer
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
                    style: AppTextStyle.medium(12, color: AppColor.outline),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

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

                SizedBox(width: 10.w),

                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: AppColor.primaryColor,
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
