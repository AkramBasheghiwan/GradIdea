import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_status_pendding.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';

class StudentProjectPending extends StatefulWidget {
  const StudentProjectPending({super.key});

  @override
  State<StudentProjectPending> createState() => _PendingProjectsViewState();
}

class _PendingProjectsViewState extends State<StudentProjectPending> {
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
            return const Center(
              child: Text(
                'لا توجد طلبات قيد الانتظار حالياً.',
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

                return CustomBuildCardStatusPendding(project: project);
              },
            ),
          );
        }

        // في حالة وجود خطأ في الصفحة الرئيسية
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
