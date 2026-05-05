import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_approve.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_pending.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/student_project_proposals_rejected.dart';

class StudentProjectProposalsView extends StatelessWidget {
  const StudentProjectProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                          Text(
                            "مقترحات المشاريع",
                            style: AppTextStyle.bold(26),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "تابع حالة مقترحاتك وإدارتها بسهولة",
                            style: AppTextStyle.medium(
                              14,
                              color: AppColor.grey,
                            ),
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
                            "12",
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

                /// search
                Container(
                  height: 54.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColor.grey,
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          "ابحث عن مشروع...",
                          style: AppTextStyle.medium(14, color: AppColor.grey),
                        ),
                      ),
                      // BuildIconSearchBar(onpressed: () {}),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// tabs
                const CustomBulidTabBar(
                  tap: [
                    Tab(text: "قيد الانتظار"),
                    Tab(text: "معتمدة"),
                    Tab(text: "مرفوض"),
                  ],
                ),

                SizedBox(height: 22.h),

                /// content
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocProvider(
                        create: (context) => StudentProposalCubit(
                          status: AppProjectsStatus.padding,
                          repository: sl(),
                        ),
                        child: const StudentProjectProposalsPending(),
                      ),
                      BlocProvider(
                        create: (context) => StudentProposalCubit(
                          status: AppProjectsStatus.approved,
                          repository: sl(),
                        ),
                        child: const StudentProjectProposalsApprove(),
                      ),
                      BlocProvider(
                        create: (context) => StudentProposalCubit(
                          status: AppProjectsStatus.approved,
                          repository: sl(),
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
      ),
    );
  }
}
