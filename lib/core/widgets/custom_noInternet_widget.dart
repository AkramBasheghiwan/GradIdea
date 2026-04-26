import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/utils/images_assests.dart';

class CustomNoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const CustomNoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // 1. إضافة لمسة من هوية التطبيق (توهج علوي خفيف)
          Positioned(
            top: -50.h,
            right: -50.w,
            child: Container(
              width: 200.r,
              height: 200.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(AppDimens.p24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 2. الصورة (الروبوت) مع أنيميشن "الطفو"
                Center(
                  child:
                      Image.asset(
                            AppImageAssets.noInternetIllustration,
                            width: 300.w,
                            fit: BoxFit.contain,
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                          )
                          .moveY(
                            begin: -10,
                            end: 10,
                            duration: 2.seconds,
                            curve: Curves.easeInOut,
                          )
                          .fadeIn(),
                ),

                SizedBox(height: AppDimens.p32.h),

                // 3. العنوان بهوية التطبيق
                Text(
                  AppStrings.noInternetTitle,
                  style: AppTextStyle.headline24BoldStyle.copyWith(
                    color: AppColor.primaryColor, // لتمييز الخطأ بلون الهوية
                  ),
                  textAlign: TextAlign.center,
                ).animate().shake(
                  delay: 500.ms,
                  duration: 400.ms,
                ), // هزة خفيفة لجذب الانتباه

                SizedBox(height: AppDimens.p16.h),

                // 4. الوصف
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.p16.w),
                  child: Text(
                    AppStrings.noInternetSubTitle,
                    style: AppTextStyle.subHeadline16NormalStyle,
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: AppDimens.p48.h),

                // 5. زر إعادة المحاولة (بنفس ستايل أزرار التطبيق)
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    minimumSize: Size(
                      200.w,
                      54.h,
                    ), // عرض مخصص ليناسب شكل الصفحة
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimens.mainButtonRadius.r,
                      ),
                    ),
                    elevation: 5,
                    shadowColor: AppColor.primaryColor.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppStrings.tryAgain,
                        style: AppTextStyle.mainButtonText,
                      ),
                    ],
                  ),
                ).animate().scale(delay: 600.ms, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
