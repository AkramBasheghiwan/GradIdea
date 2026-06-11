import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class EditProfileStepper extends StatelessWidget {
  final int currentStep;
  const EditProfileStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StepItem(
            title: "البيانات الشخصية",
            icon: Iconsax.user_edit,
            active: currentStep == 0,
            done: currentStep > 0,
          ),
        ),

        _line(currentStep >= 1),

        Expanded(
          child: _StepItem(
            title: "المعلومات",
            icon: Iconsax.teacher,
            active: currentStep == 1,
            done: currentStep > 1,
          ),
        ),

        _line(currentStep >= 2),

        Expanded(
          child: _StepItem(
            title: "مراجعة",
            icon: Iconsax.tick_circle,
            active: currentStep == 2,
            done: false,
          ),
        ),
      ],
    );
  }

  Widget _line(bool active) {
    return Container(
      width: 42.w,
      height: 2.h,
      margin: EdgeInsets.only(bottom: 28.h),
      decoration: BoxDecoration(
        color: active ? AppColor.primaryColor : AppColor.border,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.title,
    required this.icon,
    required this.active,
    required this.done,
  });

  final String title;
  final IconData icon;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final color = done || active ? AppColor.primaryColor : AppColor.grey;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                    colors: [AppColor.secondaryColor, AppColor.primaryColor],
                  )
                : null,
            color: !active
                ? (done ? AppColor.cardPurple : AppColor.white)
                : null,
            shape: BoxShape.circle,
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppColor.primaryColor.withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            done ? Iconsax.tick_circle : icon,
            color: active ? Colors.white : color,
            size: 22.sp,
          ),
        ),

        SizedBox(height: 10.h),

        Text(
          title,
          style: AppTextStyle.bold(12, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
