import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/student_project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_approve.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_pending.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_rejected.dart';

class StudentMyProposalView extends StatefulWidget {
  const StudentMyProposalView({super.key});

  @override
  State<StudentMyProposalView> createState() => _StudentMyProposalViewState();
}

class _StudentMyProposalViewState extends State<StudentMyProposalView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("مقترحات المشاريع", style: AppTextStyle.bold(26)),
                        SizedBox(height: 6.h),
                        Text(
                          "تابع حالة مقترحاتك وإدارتها بسهولة",
                          style: AppTextStyle.medium(14, color: AppColor.grey),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          color: AppColor.primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "",
                          style: AppTextStyle.bold(
                            14,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              /// tabs
              CustomBulidTabBar(
                controller: _tabController,
                tap: const [
                  Tab(text: "قيد الانتظار"),
                  Tab(text: "معتمدة"),
                  Tab(text: "مرفوض"),
                ],
              ),

              SizedBox(height: 22.h),

              /// content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocProvider(
                      create: (context) => StudentProposalCubit(
                        status: AppProjectsStatus.pending,
                        repository: sl<StudentProjectProposalRepository>(),
                      ),
                      child: const StudentProjectProposalsPending(),
                    ),
                    BlocProvider(
                      create: (context) => StudentProposalCubit(
                        status: AppProjectsStatus.approved,
                        repository: sl<StudentProjectProposalRepository>(),
                      ),
                      child: const StudentProjectProposalsApprove(),
                    ),
                    BlocProvider(
                      create: (context) => StudentProposalCubit(
                        status: AppProjectsStatus.rejected,
                        repository: sl<StudentProjectProposalRepository>(),
                      ),
                      child: const StudentProjectProposalsRejected(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
