import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class UploadProjectBuildAppBar {
  static AppBar buildAppBar({
    required bool isEdit,
    required VoidCallback onPressed,
  }) {
    return AppBar(
      backgroundColor: AppColor.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        isEdit ? 'تحديث المشروع' : 'تقديم المشروع',
        style: AppTextStyle.titleLarge18NormalStyle.copyWith(fontSize: 20.sp),
      ),
      //    if (state is UploadProjectScanSuccess) {
      //   _descController.text = state.scannedText;
      // } else if (state is UploadProjectScanFailure) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(state.errMessage)),
      //   );
      // }
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.textPrimary,
        ),
      ),
    );
  }
}
