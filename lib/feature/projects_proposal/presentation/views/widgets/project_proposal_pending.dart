import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_proposal_decesion.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervisor_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervior_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_refershe_indicater.dart';

class SupervisorProjectProposalsView extends StatefulWidget {
  const SupervisorProjectProposalsView({super.key});

  @override
  State<SupervisorProjectProposalsView> createState() =>
      _SupervisorProjectProposalsViewState();
}

class _SupervisorProjectProposalsViewState
    extends State<SupervisorProjectProposalsView> {
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
          Navigator.pop(context);
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
      },

      builder: (context, state) {
        if (state is ProjectProposalLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectProposalLoaded) {
          if (state.proposals.isEmpty) {
            return CustomRefersheIndicater(
              text: 'لا توجد طلبات قيد الانتظار حالياً.',
              onRefresh: () async {
                context
                    .read<ProjectProposalCubit>()
                    .fetchProposalsToSupervisor();
              },
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

                return CustomBuildCardProposalDecesion(
                  proposals: proposal,
                  onDelete: () {
                    context.read<ProjectProposalCubit>().deleteProposal(
                      proposal.id!,
                      proposal.fileUrl!,
                    );
                  },

                  onAccept: () {
                    context.read<ProjectProposalCubit>().acceptProposal(
                      proposal.id!,
                    );
                  },

                  onReject: (reason) {
                    context.read<ProjectProposalCubit>().rejectProposal(
                      proposal.id!,
                      reason,
                    );
                  },
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

        return CustomRefersheIndicater(
          text: 'لا توجد طلبات قيد المراجعه حالياً.',
          onRefresh: () async {
            context.read<ProjectProposalCubit>().fetchProposalsToSupervisor();
          },
        );
      },
    );
  }
}
