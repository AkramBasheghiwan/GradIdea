import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_state.dart';

class UploadProposalBuildAppBar {
  static AppBar customBuildAppBar({
    required bool isEdit,
    required BuildContext context,
    required VoidCallback onPressed,
  }) {
    return AppBar(
      backgroundColor: AppColor.background,
      elevation: 0,
      centerTitle: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          isEdit ? 'تعديل المقترح' : 'تقديم المقترح',
          key: ValueKey(isEdit),
          style: AppTextStyle.titleLarge18NormalStyle.copyWith(fontSize: 20.sp),
        ),
      ),
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.textPrimary,
        ),
      ),

      bottom:
          context.watch<UploadProposalCubit>().state.status ==
              UploadProposalStatus.loading
          ? PreferredSize(
              preferredSize: Size.fromHeight(4.h),
              child: const LinearProgressIndicator(
                backgroundColor: AppColor.background,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.primaryColor,
                ),
              ),
            )
          : null,
      // 3. إضافة أيقونة حالة في الجانب الآخر (اختياري)
      actions: [
        if (isEdit)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.edit_note_rounded, color: AppColor.primaryColor),
          ),
      ],
    );
  }
}
