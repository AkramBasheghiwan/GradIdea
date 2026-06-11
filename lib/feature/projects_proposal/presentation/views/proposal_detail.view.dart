import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/proposal_detail_view_body.dart';

class ProposalDetailView extends StatelessWidget {
  final ProjectProposals proposals;
  const ProposalDetailView({super.key, required this.proposals, required});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadProposalCubit>(),
      child: ProposalDetailBlocLisner(proposals: proposals),
    );
  }
}

class ProposalDetailBlocLisner extends StatelessWidget {
  final ProjectProposals proposals;
  const ProposalDetailBlocLisner({super.key, required this.proposals});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadProposalCubit, UploadProposalState>(
      listener: (context, state) {
        if (state.status == UploadProposalStatus.success) {
          Navigator.of(context).pop();
          AppSnackBar.show(
            context: context,
            message: 'تم حذف المقترح بنجاح',
            type: SnackBarType.success,
          );
        }

        if (state.status == UploadProposalStatus.error) {
          AppSnackBar.show(
            context: context,
            message: 'حدث خطاء اثناء رفع المقترح',
            type: SnackBarType.error,
          );
        }
      },
      child: ProposalDetailsViewBody(proposals: proposals),
    );
  }
}
