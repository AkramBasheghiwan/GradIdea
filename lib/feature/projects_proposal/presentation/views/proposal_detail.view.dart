import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/proposal_detail_view_body.dart';

class ProposalDetailView extends StatelessWidget {
  final ProjectProposals proposals;
  const ProposalDetailView({super.key, required this.proposals});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadProposalCubit>(),
      child: ProposalDetailsViewBody(proposals: proposals),
    );
  }
}
