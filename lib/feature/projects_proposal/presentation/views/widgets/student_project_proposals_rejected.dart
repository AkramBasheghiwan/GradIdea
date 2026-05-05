import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/expandable_project_proposal_card.dart';

class StudentProjectProposalsRejected extends StatefulWidget {
  const StudentProjectProposalsRejected({super.key});

  @override
  State<StudentProjectProposalsRejected> createState() =>
      _StudentProjectProposalsRejectedState();
}

class _StudentProjectProposalsRejectedState
    extends State<StudentProjectProposalsRejected> {
  @override
  void initState() {
    super.initState();

    context.read<StudentProposalCubit>().fetchMyProposals();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentProposalCubit, StudentProposalState>(
      builder: (context, state) {
        if (state is StudentProposalLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StudentProposalLoaded) {
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
                context.read<StudentProposalCubit>().fetchMyProposals(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.proposals.length,
              itemBuilder: (context, index) {
                final proposal = state.proposals[index];

                return ExpandableProjectProposalCard(
                  project: proposal,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.proposalDetail,
                      arguments: proposal,
                    );
                  },
                );
              },
            ),
          );
        }

        if (state is StudentProposalError) {
          return CustomBuildProjectErrorCard(
            message: state.message,
            onTape: () =>
                context.read<StudentProposalCubit>().fetchMyProposals(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
