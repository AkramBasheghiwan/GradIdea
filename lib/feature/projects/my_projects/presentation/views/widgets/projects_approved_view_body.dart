import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/hod_projects_cubit/hod_projects_cubit.dart';

import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/hod_projects_cubit/hod_projects_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

class ProjectsApprovedView extends StatefulWidget {
  const ProjectsApprovedView({super.key});

  @override
  State<ProjectsApprovedView> createState() => _ProjectsApprovedViewState();
}

class _ProjectsApprovedViewState extends State<ProjectsApprovedView> {
  @override
  void initState() {
    super.initState();
    context.read<HodProjectsCubit>().fetchAllProjectsByDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HodProjectsCubit, HodProjectsState>(
      listener: (context, state) {
        if (state is HodProjectsActionSuccess) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
        if (state is HodProjectsError) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },

      builder: (context, state) {
        if (state is HodProjectsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HodProjectsLoaded) {
          if (state.projects.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد طلبات مقبولة حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<HodProjectsCubit>().fetchAllProjectsByDepartment(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.projects.length,
              itemBuilder: (context, index) {
                final project = state.projects[index];

                return CustomBuildCardProjectsApproved(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.projectDetail,
                      arguments: project,
                    );
                  },
                  project: project,
                );
              },
            ),
          );
        }

        // في حالة وجود خطأ في الصفحة الرئيسية
        if (state is HodProjectsError) {
          return Center(
            child: CustomBuildProjectErrorCard(
              message: state.message,
              onTape: () {
                context.read<HodProjectsCubit>().fetchAllProjectsByDepartment();
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
