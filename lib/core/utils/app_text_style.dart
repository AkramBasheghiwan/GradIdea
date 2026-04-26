import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';

class AppTextStyle {
  AppTextStyle._();

  static const String fontFamily = 'Cairo';

  static TextStyle headline24BoldStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s24,
    fontWeight: FontWeight.bold,
    color: AppColor.textPrimary,
    height: 1.3,
  );

  static TextStyle headline32BoldStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s32,
    fontWeight: FontWeight.bold, // w700
    color: AppColor.textPrimary,
    height: 1.2,
  );

  static TextStyle titleLarge18NormalStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s18,
    fontWeight: FontWeight.w500, // Medium
    color: AppColor.textPrimary,
  );

  static TextStyle subHeadline16NormalStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.normal,
    color: AppColor.textSecondary,
    height: 1.5,
  );

  static TextStyle bodyLarge16NormalStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textPrimary,
  );
  static TextStyle link14BoldStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s14,
    fontWeight: FontWeight.bold,
    color: AppColor.accentBlue,
    decoration: TextDecoration.underline,
  );

  static TextStyle skipButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.w600,
    color: AppColor.textSecondary,
  );

  static TextStyle mainButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle loginText = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle wellComeText = TextStyle(
    fontFamily: AppTextStyle.fontFamily,
    fontSize: AppSizes.s26, // خط كبير وواضح
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle emailText = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle passwordText = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle hintText = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle caption12MediumStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s12,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSizes.s14,
    fontWeight: FontWeight.w400,
    color: AppColor.textSecondary,
  );
  ///////////////////////////////

  static TextStyle bold(double size, {Color color = AppColor.onSurface}) =>
      TextStyle(
        fontSize: size.sp,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: fontFamily,
        height: 1.2,
      );

  static TextStyle extraBold(double size, {Color color = AppColor.onSurface}) {
    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w900,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle medium(
    double size, {
    Color color = AppColor.onSurfaceVariant,
  }) => TextStyle(
    fontSize: size.sp,
    fontWeight: FontWeight.w500,
    color: color,
    height: 1.5,
  );

  static TextStyle regular(
    double size, {
    Color color = AppColor.onSurfaceVariant,
  }) =>
      TextStyle(fontSize: size.sp, fontWeight: FontWeight.normal, color: color);
}
