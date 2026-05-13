import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

Widget buildUploadHero({required bool isEditing}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.w),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xff5B67F1), Color(0xff7B61FF), Color(0xff8B5CF6)],
      ),
      borderRadius: BorderRadius.circular(32.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff5B67F1).withValues(alpha: .28),
          blurRadius: 30,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          left: -25,
          top: -20,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
        ),

        Positioned(
          right: -30,
          bottom: -30,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .06),
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.white.withValues(alpha: .18)),
              ),
              child: Text(
                isEditing ? "وضع التعديل" : "رفع مشروع جديد",
                style: AppTextStyle.medium(11, color: Colors.white),
              ),
            ),

            SizedBox(height: 22.h),

            /// icon + title
            Row(
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .18),
                    ),
                  ),
                  child: Icon(
                    isEditing ? Iconsax.edit : Iconsax.document_upload,
                    color: Colors.white,
                    size: 34.sp,
                  ),
                ),

                SizedBox(width: 18.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEditing ? "تحديث بيانات المشروع" : "رفع مشروع التخرج",
                        style: AppTextStyle.bold(22, color: Colors.white),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "أضف تفاصيل مشروعك الأكاديمي بصورة منظمة وواضحة داخل النظام",
                        style: AppTextStyle.medium(
                          12,
                          color: Colors.white.withValues(alpha: .90),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// stats row
            Row(
              children: [
                _heroInfoChip(Iconsax.folder, "مشروع أكاديمي"),

                SizedBox(width: 10.w),

                _heroInfoChip(Iconsax.document_text, "تفاصيل كاملة"),

                SizedBox(width: 10.w),

                _heroInfoChip(Iconsax.verify, "جاهز للمراجعة"),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroInfoChip(IconData icon, String title) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 16.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.medium(11, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
