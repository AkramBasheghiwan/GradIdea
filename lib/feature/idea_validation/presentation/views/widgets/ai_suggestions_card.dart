import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class AiSuggestionsCard extends StatelessWidget {
  const AiSuggestionsCard({
    super.key,
    required this.isLoading,
    required this.suggestions,
    required this.onGenerate,
  });

  final bool isLoading;
  final String? suggestions;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.primaryColor, AppColor.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(Iconsax.cpu, color: Colors.white, size: 24.sp),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Text(
                  "اقتراحات الذكاء الاصطناعي",
                  style: AppTextStyle.bold(16, color: Colors.white),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          if (isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.white))
          else if (suggestions != null)
            Text(
              suggestions!,
              style: AppTextStyle.medium(
                14,
                color: Colors.white,
              ).copyWith(height: 1.8),
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onGenerate,
                icon: const Icon(Iconsax.magicpen),
                label: const Text("توليد اقتراحات تطوير"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.primaryColor,
                  backgroundColor: Colors.white,
                  minimumSize: Size(0, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
