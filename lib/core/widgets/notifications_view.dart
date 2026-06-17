import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('الإشعارات', style: AppTextStyle.bold(22)),
        backgroundColor: AppColor.background,
        surfaceTintColor: AppColor.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColor.primaryColor.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.notification,
                  size: 36,
                  color: AppColor.primaryColor,
                ),
              ),

              const SizedBox(height: 20),

              Text('ميزة الإشعارات', style: AppTextStyle.bold(20)),

              const SizedBox(height: 12),

              Text(
                'يتم العمل على تطوير نظام الإشعارات حالياً، وسيتم توفيره في تحديثات قادمة.',
                textAlign: TextAlign.center,
                style: AppTextStyle.medium(15, color: AppColor.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
