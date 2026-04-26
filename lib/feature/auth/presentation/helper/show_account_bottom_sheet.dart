import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_style.dart';

void showAccountTypeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return Padding(
        // SafeArea لضمان عدم تداخل النص مع أزرار النظام السفلية
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20.h,
          top: 24.h,
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // لجعل النافذة تأخذ مساحة المحتوى فقط
          children: [
            Text(
              'إنشاء حساب جديد',
              style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'يرجى اختيار نوع الحساب الذي ترغب بإنشائه',
              style: AppTextStyle.bodyMedium.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 24.h),

            // الخيار الأول: حساب طالب
            _buildAccountTypeTile(
              context: context,
              title: 'حساب طالب',
              subtitle: 'للتسجيل كطالب في النظام',
              icon: Icons.school_outlined,
              onTap: () {
                Navigator.pop(context); // 1. إغلاق الـ BottomSheet أولاً
                // 2. الانتقال لشاشة تسجيل الطالب
                Navigator.pushNamed(context, AppRoutes.signUpUser);
              },
            ),

            SizedBox(height: 12.h),

            // الخيار الثاني: جهة خارجية
            _buildAccountTypeTile(
              context: context,
              title: 'حساب جهة خارجية',
              subtitle: 'للتسجيل كشركة أو مؤسسة',
              icon: Icons.business_center_outlined,
              onTap: () {
                Navigator.pop(context); // 1. إغلاق الـ BottomSheet أولاً
                // 2. الانتقال لشاشة تسجيل الجهة الخارجية
                Navigator.pushNamed(context, AppRoutes.signUpExternalEntity);
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildAccountTypeTile({
  required BuildContext context,
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16.r),
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 28.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.sp),
        ],
      ),
    ),
  );
}
