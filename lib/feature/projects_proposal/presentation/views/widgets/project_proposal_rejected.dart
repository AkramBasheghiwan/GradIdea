import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_status_rejected.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervisor_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervior_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

class SupervisorProjectProposalRejected extends StatefulWidget {
  const SupervisorProjectProposalRejected({super.key});

  @override
  State<SupervisorProjectProposalRejected> createState() =>
      _SupervisorProjectProposalRejectedState();
}

class _SupervisorProjectProposalRejectedState
    extends State<SupervisorProjectProposalRejected> {
  @override
  void initState() {
    super.initState();

    context.read<ProjectProposalCubit>().fetchProposalsToSupervisor();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectProposalCubit, ProjectProposalState>(
      builder: (context, state) {
        if (state is ProjectProposalLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectProposalLoaded) {
          if (state.proposals.isEmpty) {
            return Center(
              child: Text(
                'لا توجد طلبات مرفوضة حالياً.',
                style: AppTextStyle.bold(24, color: AppColor.primaryColor),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context
                .read<ProjectProposalCubit>()
                .fetchProposalsToSupervisor(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.proposals.length,
              itemBuilder: (context, index) {
                final proposal = state.proposals[index];

                return CustomBuildCardStatusRejected(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.proposalDetail,
                      arguments: proposal,
                    );
                  },
                  project: proposal,
                );
              },
            ),
          );
        }

        if (state is ProjectProposalError) {
          return CustomBuildProjectErrorCard(
            message: state.message,
            onTape: () => context
                .read<ProjectProposalCubit>()
                .fetchProposalsToSupervisor(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
