import 'package:graduation_management_idea_system/feature/onboarding/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBuildIllustration extends StatelessWidget {
  final OnboardingModel item;
  const OnboardingBuildIllustration({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Image.asset(
                item.image,
                width: double.infinity,
                height: 500.h,
                fit: BoxFit.cover,
              )
              .animate(
                key: ValueKey(item.image),
              ) // إعادة الأنيميشن عند تغيير الصفحة
              .fadeIn(duration: 700.ms)
              .slideY(begin: 0.1, end: 0),
    );
  }
}
