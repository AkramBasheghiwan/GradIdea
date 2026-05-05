import 'package:flutter/material.dart';

import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_detail_view_body.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectEntity projects;
  const ProjectDetailView({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ProjectDetailsViewBody(projects: projects);
  }
}
