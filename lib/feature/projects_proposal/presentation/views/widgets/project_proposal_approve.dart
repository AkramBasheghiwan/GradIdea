import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervisor_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervior_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

class SupervisorProjectProposalApprove extends StatefulWidget {
  const SupervisorProjectProposalApprove({super.key});

  @override
  State<SupervisorProjectProposalApprove> createState() =>
      _SupervisorProjectProposalApproveState();
}

class _SupervisorProjectProposalApproveState
    extends State<SupervisorProjectProposalApprove> {
  @override
  void initState() {
    super.initState();

    context.read<ProjectProposalCubit>().fetchProposalsToSupervisor();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectProposalCubit, ProjectProposalState>(
      listener: (context, state) {
        if (state is ProjectProposalActionSuccess) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
        if (state is ProjectProposalError) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },

      builder: (context, state) {
        if (state is ProjectProposalLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectProposalLoaded) {
          if (state.proposals.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد طلبات معتمده حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
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

                return CustomBuildCardProjectsApproved(
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

        // في حالة وجود خطأ في الصفحة الرئيسية
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
