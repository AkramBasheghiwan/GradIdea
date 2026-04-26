import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/cubit/cubit.dart';

void showUserActionsBottomSheet(BuildContext context, UserEntity user) {
  final UsersCubit cubit = context.read<UsersCubit>();
  final String targetUserRole =
      user.role; // نأخذ دور المستخدم المستهدف لترقيته أو تنزيله

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.transparent,
    isScrollControlled: true,
    builder: (BuildContext sheetContext) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3C), // لون الخلفية الداكن
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // خط السحب العلوي (Drag Handle)
              Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 25.h),

              // ==========================================
              // 1. قسم عرض بيانات المستخدم
              // ==========================================
              _buildUserDetailsSection(user),

              SizedBox(height: 30.h),
              const Divider(color: Colors.white24, thickness: 1),
              SizedBox(height: 20.h),

              // ==========================================
              // 2. قسم أزرار الإجراءات (Actions)
              // ==========================================

              // إذا كان المستخدم طالباً أو مستخدماً عادياً، تظهر له أزرار الترقية
              if (targetUserRole == AppRoles.user ||
                  targetUserRole == 'student') ...[
                _buildActionButton(
                  title: '👑  تعيين كرئيس قسم  👑',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _executeAction(
                      context,
                      () => cubit.changeUserRole(
                        user.uid,
                        AppRoles.headOfDepartment,
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h), // مسافة بين زري الترقية
                _buildActionButton(
                  title: '👨‍🏫  تعيين كمشرف أكاديمي  👨‍🏫',
                  textColor: Colors.black,
                  backgroundColor: AppColor.primaryColor.withValues(
                    alpha: 0.9,
                  ), // لون مميز للمشرف (أو اجعله أبيض)
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _executeAction(
                      context,
                      // تأكد من وجود AppRoles.supervisor في ملف AppRole الخاص بك
                      () => cubit.changeUserRole(user.uid, AppRoles.supervisor),
                    );
                  },
                ),
              ],

              // إذا كان المستخدم حالياً رئيس قسم أو مشرف، يظهر له زر الإلغاء (تنزيل الرتبة)
              if (targetUserRole == AppRoles.headOfDepartment ||
                  targetUserRole == AppRoles.supervisor)
                _buildActionButton(
                  title: '👤  تعيين كمستخدم عادي  👤',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _executeAction(
                      context,
                      () => cubit.changeUserRole(user.uid, AppRoles.user),
                    );
                  },
                ),

              SizedBox(height: 16.h),

              // زر الحذف (يظهر دائماً في الأسفل)
              _buildActionButton(
                title: 'حذف الحساب',
                icon: Icons.delete_outline,
                textColor: Colors.white,
                backgroundColor: const Color(0xFFD32F2F), // لون أحمر ساطع
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await _executeAction(
                    context,
                    () => cubit.deleteUser(user.uid),
                  );
                },
              ),

              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 20.h,
              ), // مسافة سفلية للأمان
            ],
          ),
        ),
      );
    },
  );
}

// ========================================================
// ودجت عرض بيانات المستخدم (لم يتغير)
// ========================================================
Widget _buildUserDetailsSection(UserEntity user) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.05), // خلفية شفافة خفيفة
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.white12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 16.h),
        _buildInfoRow(Icons.email_outlined, 'البريد', user.email),

        if (user.specialization != null && user.specialization!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          _buildInfoRow(Icons.school_outlined, 'التخصص', user.specialization!),
        ],

        if (user.companyName != null && user.companyName!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          _buildInfoRow(
            Icons.business_center_outlined,
            'الجهة',
            user.companyName!,
          ),
        ],

        if (user.phone != null && user.phone!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          _buildInfoRow(Icons.phone_outlined, 'الجوال', user.phone!),
        ],
      ],
    ),
  );
}

// ودجت فرعي لترتيب أيقونة + عنوان + قيمة
Widget _buildInfoRow(IconData icon, String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Colors.white70, size: 20.sp),
      SizedBox(width: 12.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ========================================================
// الأزرار وإجراءات الـ Cubit
// ========================================================
Widget _buildActionButton({
  required String title,
  required Color textColor,
  required Color backgroundColor,
  required VoidCallback onTap,
  IconData? icon,
}) {
  return SizedBox(
    width: double.infinity,
    height: 56.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, color: textColor, size: 22.sp),
            SizedBox(width: 10.w),
          ],
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    ),
  );
}

// دالة مساعدة لتنفيذ الإجراء (حذف/تعديل)
Future<void> _executeAction(
  BuildContext context,
  Future<String?> Function() action,
) async {
  final String? errorMessage = await action();

  if (context.mounted) {
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تمت العملية بنجاح!',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
