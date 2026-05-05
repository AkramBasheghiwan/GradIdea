import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/search_project_view_body.dart';

class SearchProjectsView extends StatelessWidget {
  const SearchProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectSearchBloc>(),
      child: const ProjectSearchPageBody(),
    );
  }
}
