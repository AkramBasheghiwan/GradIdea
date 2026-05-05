import 'dart:developer';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_state.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/helper/custom_build_app_bar_function.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/widgets/uploud_proposal_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploudProposalBlocConsumer extends StatelessWidget {
  final ProjectProposals? projects;
  const UploudProposalBlocConsumer({super.key, this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: customBuildAppBar(projects: projects, context: context),
      body: BlocConsumer<UploadProposalCubit, UploadProposalState>(
        listener: (context, state) {
          if (state.status == UploadProposalStatus.success) {
            AppSnackBar.show(
              context: context,
              message: 'تم رفع المقترح بنجاح! 🎉',
              type: SnackBarType.success,
            );
            Navigator.pop(context); // للعودة للصفحة السابقة بعد النجاح
          } else if (state.status == UploadProposalStatus.error) {
            AppSnackBar.show(
              context: context,
              message: state.errorMessage!,
              type: SnackBarType.error,
            );

            log(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return UploudProposalViewBody(
            isLoading: state.status == UploadProposalStatus.loading,
            projects: projects,
          );
        },
      ),
    );
  }
}
