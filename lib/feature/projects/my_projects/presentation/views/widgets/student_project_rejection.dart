import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_status_rejected.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';

class StudentProjectRejected extends StatefulWidget {
  const StudentProjectRejected({super.key});

  @override
  State<StudentProjectRejected> createState() => _StudentProjectRejectedState();
}

class _StudentProjectRejectedState extends State<StudentProjectRejected> {
  @override
  void initState() {
    super.initState();

    context.read<StudentProjectCubit>().fetchMyProjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentProjectCubit, StudentProjectState>(
      builder: (context, state) {
        if (state is StudentProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StudentProjectLoaded) {
          if (state.proposals.isEmpty) {
            return Center(
              child: Text(
                'لا توجد طلبات مرفوضة حالياً.',
                style: AppTextStyle.bold(24, color: AppColor.primaryColor),
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

                return CustomBuildCardStatusRejected(
                  project: project,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.projectDetail,
                      arguments: project,
                    );
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
