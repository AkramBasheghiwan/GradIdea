// widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dimens.dart';
import '../../../../../core/utils/app_text_style.dart';

class CustomAuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(dynamic)? validator;

  const CustomAuthTextField({
    super.key,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimens.p8.h),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.bodyMedium.copyWith(
              color: AppColor.textSecondary.withValues(alpha: 0.5),
            ),

            prefixIcon: Icon(
              prefixIcon,
              color: AppColor.primaryColor,
              size: AppDimens.iconSmall.r,
            ),
            suffixIcon: suffixIcon,
            fillColor: AppColor.inputBackground,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.r12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: AppDimens.p16.h),
          ),
        ),
      ],
    );
  }
}
