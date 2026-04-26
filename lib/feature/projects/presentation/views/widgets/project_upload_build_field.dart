import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBuildField extends StatelessWidget {
  final String label;
  final IconData icon;
  final int? maxLines;
  final String? hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const ProjectUploadBuildField({
    super.key,
    required this.label,
    required this.icon,
    this.maxLines,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            validator: validator,
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: AppColor.secondaryColor,
                size: 20.r,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColor.textSecondary.withValues(alpha: 0.4),
                fontSize: 13.sp,
              ),
              fillColor: AppColor.inputBackground.withValues(alpha: 0.5),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
