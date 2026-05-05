import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class HeroCard extends StatelessWidget {
  final VoidCallback? onTap;
  const HeroCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          Container(
                height: 300.h,
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColor.primaryColor, Color(0xff655BFF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 42,
                      offset: const Offset(0, 22),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      left: -10,
                      child: _blurCircle(
                        120,
                        Colors.white.withValues(alpha: 0.08),
                      ),
                    ),

                    Positioned(
                      bottom: -30,
                      right: -10,
                      child: _blurCircle(
                        180,
                        Colors.white.withValues(alpha: 0.08),
                      ),
                    ),

                    Positioned(
                      top: 12,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.flash_1,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "AI Powered",
                              style: AppTextStyle.bold(12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 70,
                      left: 0,
                      child: Container(
                        width: 86.w,
                        height: 86.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                        child: Center(
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.cpu,
                              color: AppColor.primaryColor,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),

                        Text(
                          "تأكد من فكرتك\nبالذكاء الاصطناعي",
                          style: AppTextStyle.bold(28, color: Colors.white),
                        ),

                        SizedBox(height: 10.h),

                        Text(
                          "تحليل ذكي + اقتراحات تطوير فورية",
                          style: AppTextStyle.medium(14, color: Colors.white70),
                        ),

                        SizedBox(height: 24.h),

                        Container(
                          height: 58.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              "ابدأ الآن",
                              style: AppTextStyle.bold(
                                15,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fade(duration: 600.ms)
              .slideY(begin: .15)
              .shimmer(duration: 3.seconds),
    );
  }

  Widget _blurCircle(double size, Color color) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
