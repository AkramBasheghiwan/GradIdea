import 'dart:developer';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/widgets/uploud_proposal_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploudProposalBlocConsumer extends StatelessWidget {
  final ProjectProposals? projects;
  const UploudProposalBlocConsumer({super.key, this.projects});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadProposalCubit, UploadProposalState>(
      listener: (context, state) {
        if (state.status == UploadProposalStatus.updateSucess) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          AppSnackBar.show(
            context: context,
            message: 'تم تحديث المقترح بنجاح! 🎉',
            type: SnackBarType.success,
          );
        }
        if (state.status == UploadProposalStatus.success) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          AppSnackBar.show(
            context: context,
            message: 'تم رفع المقترح بنجاح! 🎉',
            type: SnackBarType.success,
          );
        }
        if (state.status == UploadProposalStatus.uploadDisabled) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('تنبيه'),
              content: Text(state.errorMessage!),
            ),
          );
        }
        if (state.status == UploadProposalStatus.error) {
          AppSnackBar.show(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );

          log(state.errorMessage!);
        }
      },
      child: UploudProposalViewBody(isLoading: false, projects: projects),
    );
  }
}
