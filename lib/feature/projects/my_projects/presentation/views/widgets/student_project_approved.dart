import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';

import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_refershe_indicater.dart';

class StudentProjectApproved extends StatefulWidget {
  const StudentProjectApproved({super.key});

  @override
  State<StudentProjectApproved> createState() => _StudentProjectApprovedState();
}

class _StudentProjectApprovedState extends State<StudentProjectApproved> {
  @override
  void initState() {
    super.initState();

    context.read<StudentProjectCubit>().fetchMyProjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentProjectCubit, StudentProjectState>(
      listener: (context, state) {
        if (state is StudentProjectActionSuccess) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
        if (state is StudentProjectError) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },

      builder: (context, state) {
        if (state is StudentProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StudentProjectLoaded) {
          if (state.proposals.isEmpty) {
            return CustomRefersheIndicater(
              text: 'لا توجد طلبات معتمدة حالياً.',
              onRefresh: () async {
                context.read<StudentProjectCubit>().fetchMyProjects();
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<StudentProjectCubit>().fetchMyProjects(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.proposals.length,
              itemBuilder: (context, index) {
                final project = state.proposals[index];

                return CustomBuildCardProjectsApproved(
                  project: project,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.projectDetail,
                      arguments: project,
                    ).then((_) {
                      if (!context.mounted) return;

                      context.read<StudentProjectCubit>().fetchMyProjects();
                    });
                  },
                );
              },
            ),
          );
        }

        if (state is StudentProjectError) {
          return CustomBuildProjectErrorCard(
            message: state.message,
            onTape: () => context.read<StudentProjectCubit>().fetchMyProjects(),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<StudentProjectCubit>().fetchMyProjects();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Center(
                child: Text(
                  'لايوجد مشاريع تم رفعها',
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
