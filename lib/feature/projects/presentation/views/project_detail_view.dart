import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';

import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_detail_view_body.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectEntity projects;
  const ProjectDetailView({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadProjectCubit>(),
      child: ProjectDetailBlocLisner(projects: projects),
    );
  }
}

class ProjectDetailBlocLisner extends StatelessWidget {
  final ProjectEntity projects;
  const ProjectDetailBlocLisner({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadProjectCubit, UploadProjectState>(
      listener: (context, state) {
        if (state.status == UploadProjectStatus.success) {
          AppSnackBar.show(
            context: context,
            message: 'تم حذف المشروع بنجاح',
            type: SnackBarType.success,
          );
        }
        Navigator.of(context).pop();
        if (state.status == UploadProjectStatus.error) {
          AppSnackBar.show(
            context: context,
            message: 'حدث خطاء اثناء حذف المشروع ',
            type: SnackBarType.error,
          );
        }
      },
      child: ProjectDetailsViewBody(projects: projects),
    );
  }
}
