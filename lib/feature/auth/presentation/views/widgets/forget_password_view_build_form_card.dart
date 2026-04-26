import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_text_style.dart';

class ForgetPasswordViewBuildFormCard extends StatelessWidget {
  final Function()? onPressed;
  final bool isLoading;
  final TextEditingController controller;
  final List<Widget> children;
  const ForgetPasswordViewBuildFormCard({
    required this.controller,
    required this.isLoading,
    required this.onPressed,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.secondaryColor.withValues(
              alpha: 0.15,
            ), // الظل السماوي المبدع
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // حقل البريد الإلكتروني المطور
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyle.bodyLarge16NormalStyle,
            decoration: InputDecoration(
              hintText: 'البريد الجامعي',
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColor.secondaryColor,
              ),
              fillColor: AppColor.inputBackground,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال البريد الإلكتروني';
              }

              return null;
            },
          ),

          SizedBox(height: 24.h),

          // زر الإرسال بتأثير الـ Glow
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                elevation: 5,
                shadowColor: AppColor.primaryColor.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: AppColor.white)
                  : Text('إرسال الرابط', style: AppTextStyle.mainButtonText),
            ),
          ).animate().scale(delay: 600.ms, curve: Curves.easeOutBack),

          Column(children: children),
        ],
      ),
    ).animate().slideY(begin: 0.3, end: 0, duration: 600.ms);
  }
}
