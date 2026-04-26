import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/helper/functions.dart';
// تأكد من استيراد ملف الأدوار إذا لم يكن مستورداً
// import 'package:graduation_management_idea_system/core/utils/app_role.dart';

class BuildUserCard extends StatelessWidget {
  final UserEntity users;
  final int index;

  const BuildUserCard({required this.users, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.r), // زيادة الـ padding قليلاً لراحة العين
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            ), // حد خفيف جداً يبرز الكارد
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              // ==========================================
              // 1. الصورة الرمزية (Avatar) مع التدرج
              // ==========================================
              Container(
                padding: EdgeInsets.all(3.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColor.secondaryColor,
                      AppColor.primaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(2.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 26.r,
                    backgroundColor: AppColor.primaryColor.withValues(
                      alpha: 0.1,
                    ),
                    // عرض الحرف الأول من الاسم في حال عدم وجود صورة
                    child: Text(
                      users.name.isNotEmpty
                          ? users.name.substring(0, 1).toUpperCase()
                          : '?',
                      style: AppTextStyle.bold(20),
                    ),
                    // backgroundImage: users.image.isNotEmpty ? NetworkImage(users.image) : null,
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // ==========================================
              // 2. معلومات المستخدم (الاسم، الدور، الإيميل)
              // ==========================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            users.name,
                            style: AppTextStyle.titleLarge18NormalStyle
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // لمنع طفح النص
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      users.email,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    // شارة توضح دور المستخدم (Role Badge)
                    _buildRoleBadge(users.role),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              // ==========================================
              // 3. زر الإجراءات (إدارة المستخدم)
              // ==========================================
              Material(
                color: AppColor.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    // فتح نافذة الإجراءات
                    showUserActionsBottomSheet(context, users);
                  },
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.tune_rounded, // أيقونة تعبر عن "إدارة/إعدادات"
                      size: 20.r,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: (50 * index).ms,
        ) // تقليل الديلي قليلاً لسرعة الظهور
        .slideY(
          begin: 0.2, // تقليل مسافة الانزلاق لجعلها أنعم
          end: 0,
          curve: Curves.easeOutQuart,
          duration: 500.ms,
        );
  }

  // ==========================================
  // دالة مساعدة لبناء شارة الدور (Role Badge)
  // ==========================================
  Widget _buildRoleBadge(String role) {
    Color badgeColor;
    String roleName;

    // تحديد اللون والاسم بناءً على الدور
    switch (role.toLowerCase()) {
      case 'user':
        badgeColor = AppColor.secondaryColor;
        roleName = 'طالب';
        break;
      case 'supervisor':
        badgeColor = Colors.teal;
        roleName = 'مشرف أكاديمي';
        break;
      case 'head_of_department':
        badgeColor = Colors.orange.shade700;
        roleName = 'رئيس قسم';
        break;
      case 'company':
        badgeColor = Colors.blueAccent;
        roleName = 'جهة خارجية';
        break;
      default:
        badgeColor = Colors.grey;
        roleName = 'مستخدم';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        roleName,
        style: TextStyle(
          color: badgeColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo', // استخدم خطك الافتراضي
        ),
      ),
    );
  }
}
