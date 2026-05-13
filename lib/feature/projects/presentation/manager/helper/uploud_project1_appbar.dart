import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

PreferredSizeWidget buildProjectUploadAppBar({
  required BuildContext context,
  required bool isEditing,
  VoidCallback? onDelete,
  VoidCallback? onEdit,
}) {
  final role = CacheHelper.getData(key: "role");

  final canManage = role == "admin" || role == "head_of_department";

  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColor.background,

    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColor.textPrimary,
      ),
    ),

    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withValues(alpha: .12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isEditing ? Iconsax.edit : Iconsax.document_upload,
            color: AppColor.primaryColor,
            size: 18.sp,
          ),
        ),

        SizedBox(width: 10.w),

        Text(
          isEditing ? "تعديل المشروع" : "رفع مشروع جديد",
          style: AppTextStyle.bold(18),
        ),
      ],
    ),

    actions: canManage && isEditing
        ? [
            IconButton(
              tooltip: "تعديل",
              onPressed: onEdit,
              icon: Icon(Iconsax.edit_2, color: Colors.blue.shade700),
            ),

            IconButton(
              tooltip: "حذف",
              onPressed: onDelete,
              icon: const Icon(Iconsax.trash, color: Colors.red),
            ),

            SizedBox(width: 6.w),
          ]
        : [SizedBox(width: 10.w)],
  );
}
