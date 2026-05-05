import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_bloc_consumer.dart';

class ProjectsUploadView extends StatelessWidget {
  final ProjectEntity? projects;
  const ProjectsUploadView({super.key, this.projects});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadProjectCubit>(
      create: (_) => UploadProjectCubit(repository: sl()),
      child: const ProjectUploadBlocConsumer(),
    );
  }
}
