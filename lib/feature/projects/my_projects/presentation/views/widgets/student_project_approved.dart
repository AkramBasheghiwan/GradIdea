import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';

import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';

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
            return const Center(
              child: Text(
                'لا توجد طلبات معتمدة حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
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
                    // Handle card tap, e.g., navigate to project details
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

        return const SizedBox();
      },
    );
  }
}
