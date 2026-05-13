import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/validation_result_entity.dart';
import 'package:iconsax/iconsax.dart';

class ValidationResultCard extends StatelessWidget {
  const ValidationResultCard({super.key, required this.result});

  final ValidationResultEntity result;

  @override
  Widget build(BuildContext context) {
    final similarity = result.similarProjects.isNotEmpty
        ? result.similarProjects.first.similarityPercentage
        : 0.0;

    final isUnique = result.isUnique;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: (isUnique ? Colors.green : Colors.orange).withValues(
                alpha: .12,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnique ? Iconsax.tick_circle : Iconsax.warning_2,
              size: 38.sp,
              color: isUnique ? Colors.green : Colors.orange,
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            isUnique ? "فكرة مبتكرة" : "يوجد تشابه",
            style: AppTextStyle.bold(22),
          ),

          SizedBox(height: 10.h),

          Text(
            isUnique
                ? "لم يتم العثور على مشاريع مشابهة"
                : "${similarity.toStringAsFixed(1)}%",
            style: AppTextStyle.extraBold(
              34,
              color: isUnique ? Colors.green : Colors.orange,
            ),
          ),

          SizedBox(height: 10.h),

          Text(
            isUnique
                ? "يمكنك التقديم بهذه الفكرة"
                : "هناك مشاريع قريبة من فكرتك",
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
