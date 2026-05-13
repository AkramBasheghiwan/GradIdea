import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/custom_buttom.dart';
import 'package:iconsax/iconsax.dart';

class ValidationInputCard extends StatelessWidget {
  const ValidationInputCard({
    super.key,
    required this.controller,
    required this.onValidate,
  });

  final TextEditingController controller;
  final VoidCallback onValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .06),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Iconsax.magic_star,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text("اكتب فكرة مشروعك", style: AppTextStyle.bold(16)),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          TextField(
            controller: controller,
            maxLines: 7,
            style: AppTextStyle.medium(14),
            decoration: InputDecoration(
              hintText:
                  "اشرح فكرة مشروعك بشكل واضح...\nما المشكلة التي يحلها؟\nما التقنية المستخدمة؟",
              hintStyle: AppTextStyle.medium(13, color: AppColor.outline),
              filled: true,
              fillColor: AppColor.background,
              contentPadding: EdgeInsets.all(18.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          SizedBox(height: 18.h),

          CustomButton(
            text: "تحليل الفكرة",
            icon: Iconsax.search_normal,
            onPressed: onValidate,
          ),
        ],
      ),
    );
  }
}
