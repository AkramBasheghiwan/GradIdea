import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/get_project_repository.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/get_project_detail/get_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/get_project_detaile_view_body.dart';

class GetProjectDetaileView extends StatelessWidget {
  final String projectId;
  const GetProjectDetaileView({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProjectCubit(
        sl<GetProjectRepository>()..getProjectDetaile(projectId),
      ),
      child: const GetProjectDetaileViewBody(),
    );
  }
}
