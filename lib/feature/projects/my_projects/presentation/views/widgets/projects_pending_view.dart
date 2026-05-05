import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/widgets/Custom_build_decision_card.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/hod_projects_cubit/hod_projects_cubit.dart';

import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/hod_projects_cubit/hod_projects_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

class ProjectsPendingView extends StatefulWidget {
  const ProjectsPendingView({super.key});

  @override
  State<ProjectsPendingView> createState() => _ProjectsPendingViewState();
}

class _ProjectsPendingViewState extends State<ProjectsPendingView> {
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
                'لا توجد طلبات قيد الانتظار حالياً.',
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

                return CustomBuildDecisionCard(
                  project: project,

                  onAccept: () {
                    context.read<HodProjectsCubit>().acceptProposal(project.id);
                  },

                  onReject: (reason) {
                    context.read<HodProjectsCubit>().rejectProposal(
                      project.id,
                      reason,
                    );
                  },
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
