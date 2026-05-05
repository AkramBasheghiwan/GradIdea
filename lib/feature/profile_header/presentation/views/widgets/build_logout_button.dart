import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_text_style.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: onTap,
      child: Container(
        height: 62.h,
        decoration: BoxDecoration(
          color: const Color(0xffFEF2F2),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: const Color(0xffFECACA)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.logout, color: Colors.red.shade600),
            SizedBox(width: 10.w),
            Text(
              "تسجيل الخروج",
              style: AppTextStyle.bold(14, color: Colors.red.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
