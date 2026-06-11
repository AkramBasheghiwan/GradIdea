import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/supervisor_proposal_cubite.dart/supervisor_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/project_proposal_approve.dart';

class SupervisorOnProposalsApprovedView extends StatelessWidget {
  const SupervisorOnProposalsApprovedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectProposalCubit(
        repository: sl<ProjectProposalRepository>(),
        status: AppProjectsStatus.approved,
      ),
      child: Scaffold(
        backgroundColor: AppColor.background,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.background,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 20.w,
          title: Text("المشاريع المشرف عليها", style: AppTextStyle.bold(20)),
        ),

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// simple description (light header)
                Text(
                  "متابعة المشاريع المعتمدة التي تشرف عليها حالياً",
                  style: AppTextStyle.medium(13, color: AppColor.grey),
                ),

                SizedBox(height: 18.h),

                /// divider subtle
                Container(height: 1, color: Colors.grey.withValues(alpha: .08)),

                SizedBox(height: 16.h),

                /// list
                const Expanded(child: SupervisorProjectProposalApprove()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
