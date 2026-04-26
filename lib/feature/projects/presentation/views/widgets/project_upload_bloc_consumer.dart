import 'dart:developer';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/projects_upload_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBlocConsumer extends StatelessWidget {
  const ProjectUploadBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.uploadTitle,
          style: AppTextStyle.titleLarge18NormalStyle.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.textPrimary,
          ),
        ),
      ),
      body: BlocConsumer<UploadProjectCubit, UploadProjectState>(
        listener: (context, state) {
          if (state.status == UploadProjectStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم رفع المشروع بنجاح! 🎉')),
            );
            Navigator.pop(context); // للعودة للصفحة السابقة بعد النجاح
          } else if (state.status == UploadProjectStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
            log(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return ProjectUploadViewBody(
            isLoading: state.status == UploadProjectStatus.loading,
          );
        },
      ),
    );
  }
}
