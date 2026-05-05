import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key, this.onBack, this.onNext});

  final VoidCallback? onBack;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(icon: Iconsax.arrow_right_3, onTap: onBack),

        const Spacer(),

        Column(
          children: [
            Text("تعديل الملف الشخصي", style: AppTextStyle.bold(22)),
            SizedBox(height: 4.h),
            Text(
              "حدّث معلوماتك الشخصية والأكاديمية",
              style: AppTextStyle.medium(12),
            ),
          ],
        ),

        const Spacer(),

        _ActionButton(icon: Iconsax.arrow_left_2, onTap: onNext),
      ],
    ).animate().fade(duration: 400.ms).slideY(begin: -.15);
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: onTap,
        child: Ink(
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, size: 22.sp, color: AppColor.border),
        ),
      ),
    );
  }
}
