import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_decision_card.dart';

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
          return RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<HodProjectsCubit>()
                  .fetchAllProjectsByDepartment();
            },
            child: state.projects.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 250),
                      Center(
                        child: Text(
                          'لا توجد طلبات قيد الانتظار حالياً.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];
                      return CustomBuildDecisionCards(
                        project: project,
                        onDelete: () {
                          context.read<HodProjectsCubit>().deleteProposal(
                            project.id!,
                            project.fileUrl!,
                          );
                        },
                        onAccept: () {
                          context.read<HodProjectsCubit>().acceptProject(
                            project.id!,
                          );
                        },
                        onReject: (reason) {
                          context.read<HodProjectsCubit>().rejectProject(
                            project.id!,
                            reason,
                          );
                        },
                      );
                    },
                  ),
          );
        }

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
        if (state is HodProjectsInitial) {
          return Center(
            child: Text(
              'لايوجد مشاريع قيد المراجعه',
              style: AppTextStyle.bold(18, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await context
                .read<HodProjectsCubit>()
                .fetchAllProjectsByDepartment();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Center(
                child: Text(
                  'لايوجد مشاريع قيد المراجعه',
                  style: AppTextStyle.bold(18, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
