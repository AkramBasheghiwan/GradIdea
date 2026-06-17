import 'dart:developer';

import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/view_widget/uploud_projects_body.dart';
//import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/projects_upload_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectUploadBlocConsumer extends StatelessWidget {
  const ProjectUploadBlocConsumer({super.key, this.projects});
  final ProjectEntity? projects;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadProjectCubit, UploadProjectState>(
      listener: (context, state) {
        if (state.status == UploadProjectStatus.uploadDisabled) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('تنبيه'),
              content: Text(state.errorMessage!),
            ),
          );
        }
        if (state.status == UploadProjectStatus.success) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          AppSnackBar.show(
            context: context,
            message: 'تم رفع المشروع بنجاح! ',
            type: SnackBarType.success,
          );
        }
        if (state.status == UploadProjectStatus.error) {
          AppSnackBar.show(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );
          log(state.errorMessage!);
        }
        if (state.status == UploadProjectStatus.updateSuccess) {
          AppSnackBar.show(
            context: context,
            message: 'تم تحديث المشروع بنجاح! ',
            type: SnackBarType.success,
          );
        }
      },

      builder: (context, state) {
        return ProjectUploadViewBodys(
          projects: projects,
          isLoading: state.status == UploadProjectStatus.loading,
        );
      },
    );
  }
}
