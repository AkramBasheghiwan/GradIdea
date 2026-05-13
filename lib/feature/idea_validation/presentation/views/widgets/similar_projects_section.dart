import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:iconsax/iconsax.dart';

class SimilarProjectsSection extends StatelessWidget {
  const SimilarProjectsSection({super.key, required this.projects});

  final List<SimilarProjectEntity> projects;

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.folder_open,
              color: AppColor.primaryColor,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Text("المشاريع المشابهة", style: AppTextStyle.bold(18)),
          ],
        ),

        SizedBox(height: 18.h),

        ...projects.map(_buildCard),
      ],
    );
  }

  Widget _buildCard(SimilarProjectEntity project) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Icon(
              Iconsax.document_text,
              color: AppColor.primaryColor,
              size: 26.sp,
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bold(15),
                ),

                SizedBox(height: 6.h),

                Text(
                  "${project.department} • ${project.year}",
                  style: AppTextStyle.medium(12, color: Colors.grey.shade600),
                ),

                SizedBox(height: 8.h),

                Text(
                  project.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.medium(12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              "${project.similarityPercentage.toStringAsFixed(0)}%",
              style: AppTextStyle.bold(12, color: Colors.orange.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
