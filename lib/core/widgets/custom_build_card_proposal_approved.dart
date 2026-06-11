import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

import 'package:iconsax/iconsax.dart';

class CustomBuildCardProposalApproved extends StatelessWidget {
  const CustomBuildCardProposalApproved({
    super.key,
    required this.onTap,
    required this.proposal,
  });

  final VoidCallback onTap;
  final ProjectProposals proposal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 18.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: .06),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Header
            Row(
              children: [
                Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    gradient: AppColor.primaryGradient,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Iconsax.flash_1, // 💡 فكرة
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    "دفعة ${proposal.year}",
                    style: AppTextStyle.bold(11, color: AppColor.primaryColor),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// 🔹 Title (كامل)
            Text(proposal.name, style: AppTextStyle.bold(16)),

            SizedBox(height: 10.h),

            /// 🔹 Description
            Text(
              proposal.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.medium(13, color: AppColor.grey),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Supervisor
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Iconsax.profile_2user, // 👨‍🏫
                    size: 16.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(width: 8.w),

                Expanded(
                  child: Text(
                    proposal.supervisor,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.medium(13, color: AppColor.outline),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// 🔹 Footer
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Iconsax.people, // 👥 طلاب
                    size: 16.sp,
                    color: AppColor.primaryColor,
                  ),
                ),

                SizedBox(width: 8.w),

                Text(
                  "${proposal.students.length} طالب",
                  style: AppTextStyle.medium(13, color: AppColor.outline),
                ),

                const Spacer(),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Iconsax.arrow_left_2, // 👈 سهم أنعم
                    size: 18.sp,
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
