import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_proposal_status_rejected.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

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
            return const Center(
              child: Text(
                'لا توجد طلبات المقترحات  مرفوضة حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
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

                return CustomBuildCardProposalStatusRejected(
                  proposal: proposal,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.uploudProposal,
                      arguments: proposal,
                    ).then((_) {
                      if (!context.mounted) return;

                      context.read<StudentProposalCubit>().fetchMyProposals();
                    });
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
