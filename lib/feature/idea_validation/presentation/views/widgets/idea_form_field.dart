import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class IdeaFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final IconData icon;

  const IdeaFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) return "هذا الحقل مطلوب ";
        return null;
      },
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTextStyle.medium(14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.medium(14, color: AppColor.outlineVariant),
        prefixIcon: Icon(icon, color: AppColor.primaryColor),
        filled: true,
        fillColor: AppColor.background,
        contentPadding: EdgeInsets.all(18.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(
            color: AppColor.primaryColor.withValues(alpha: .25),
          ),
        ),
      ),
    );
  }
}
