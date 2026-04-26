// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_dimens.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/app_text_style.dart';
// import '../../../../../core/utils/images_assests.dart';

// class SplashViewBody extends StatelessWidget {
//   const SplashViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background,
//       body: Stack(
//         children: [
//           Positioned(
//             top: -100.h,
//             left: -100.w,
//             child: Container(
//               width: 400.w,
//               height: 400.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     AppColor.primaryColor.withValues(alpha: 0.2),
//                     AppColor.background.withValues(alpha: 0),
//                   ],
//                 ),
//               ),
//             ),
//           ).animate().fadeIn(duration: 1200.ms),

//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(AppImageAssets.logo, width: 180.w, height: 180.h)
//                     .animate()
//                     .fadeIn(duration: 800.ms)
//                     .scale(delay: 200.ms, curve: Curves.easeOutBack),

//                 SizedBox(height: AppDimens.p32.h),

//                 Text(
//                       AppStrings.appName,
//                       style: AppTextStyle.headline32BoldStyle,
//                       textAlign: TextAlign.center,
//                     )
//                     .animate()
//                     .fadeIn(delay: 500.ms, duration: 600.ms)
//                     .slideY(begin: 0.3, end: 0),

//                 SizedBox(height: AppDimens.p8.h),

//                 Text(
//                       AppStrings.splashTagline,
//                       style: AppTextStyle.subHeadline16NormalStyle,
//                       textAlign: TextAlign.center,
//                     )
//                     .animate()
//                     .fadeIn(delay: 800.ms, duration: 600.ms)
//                     .slideY(begin: 0.5, end: 0),
//               ],
//             ),
//           ),

//           Positioned(
//             bottom: AppDimens.p48.h,
//             left: 0,
//             right: 0,
//             child: Text(
//               AppStrings.betaVersion,
//               style: AppTextStyle.caption12MediumStyle.copyWith(
//                 color: AppColor.textSecondary.withValues(alpha: 0.6),
//               ),
//               textAlign: TextAlign.center,
//             ).animate().fadeIn(delay: 1200.ms),
//           ),
//         ],
//       ),
//     );
//   }
// }import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dimens.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/utils/images_assests.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        // هنا تضع كود الانتقال الخاص بك (مثال باستخدام GoRouter أو Navigator)
        // Navigator.pushReplacementNamed(context, Routes.onBoardingView);
        print("Transitioning to next screen...");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // 1. الخلفية الحيوية (Blobs)
          _buildAnimatedBlob(
            top: -50.h,
            left: -50.w,
            color: AppColor.primaryColor.withValues(alpha: 0.15),
            duration: 4.seconds,
          ),
          _buildAnimatedBlob(
            bottom: 100.h,
            right: -80.w,
            color: AppColor.primaryColor.withValues(alpha: 0.1),
            duration: 6.seconds,
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(color: Colors.transparent),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // اللوجو يظهر أولاً مع نبضة خفيفة ولمعة
                Image.asset(AppImageAssets.logo, width: 160.w, height: 160.h)
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    )
                    .then() // بعد الانتهاء ابدأ اللمعة
                    .shimmer(duration: 1500.ms, color: Colors.white30),

                SizedBox(height: 40.h),

                // اسم التطبيق يظهر بتأثير الكتابة أو الصعود
                Text(
                      AppStrings.appName,
                      style: AppTextStyle.headline32BoldStyle.copyWith(
                        letterSpacing: 1.2,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 800.ms)
                    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),

                SizedBox(height: 12.h),

                // النص الأخير (Tagline) يظهر متأخراً قليلاً ليكتمل المشهد
                Text(
                      AppStrings.splashTagline.toUpperCase(),
                      style: AppTextStyle.subHeadline16NormalStyle.copyWith(
                        color: AppColor.textSecondary.withValues(alpha: 0.7),
                        letterSpacing: 4.w,
                      ),
                    )
                    .animate()
                    .fadeIn(
                      delay: 1200.ms,
                      duration: 800.ms,
                    ) // تأخير مقصود ليراه المستخدم
                    .slideY(begin: 0.5, end: 0),
              ],
            ),
          ),

          // 3. التذييل (Footer)
          Positioned(
            bottom: AppDimens.p48.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
               
                SizedBox(
                      width: 100.w,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColor.primaryColor.withValues(
                          alpha: 0.1,
                        ),
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 1500.ms)
                    .scaleX(begin: 0, end: 1, duration: 2500.ms),

                SizedBox(height: 16.h),

                Text(
                  AppStrings.betaVersion,
                  style: AppTextStyle.caption12MediumStyle.copyWith(
                    color: AppColor.textSecondary.withValues(alpha: 0.5),
                  ),
                ).animate().fadeIn(delay: 2000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBlob({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required Color color,
    required Duration duration,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child:
          Container(
                width: 350.w,
                height: 350.h,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .move(
                begin: const Offset(-20, -20),
                end: const Offset(20, 20),
                duration: duration,
              ),
    );
  }
}
