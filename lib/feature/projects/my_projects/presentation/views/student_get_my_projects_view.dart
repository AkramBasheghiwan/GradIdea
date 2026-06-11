import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/widgets/student_project_approved.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/widgets/student_project_pendding.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/widgets/student_project_rejection.dart';
import 'package:iconsax/iconsax.dart';

class StudentProjectView extends StatefulWidget {
  const StudentProjectView({super.key});

  @override
  State<StudentProjectView> createState() => _StudentProjectViewState();
}

class _StudentProjectViewState extends State<StudentProjectView>
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
              /// Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("مشاريعي", style: AppTextStyle.bold(26)),
                        SizedBox(height: 6.h),
                        Text(
                          "تابع حالة مشروعك وإدارتها بسهولة",
                          style: AppTextStyle.medium(14, color: AppColor.grey),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.document,
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

              /// Tabs
              CustomBulidTabBar(
                controller: _tabController,
                tap: [
                  Tab(
                    child: Text("قيد الانتظار", style: AppTextStyle.medium(16)),
                  ),
                  Tab(child: Text("معتمد", style: AppTextStyle.medium(16))),
                  Tab(child: Text("مرفوض", style: AppTextStyle.medium(16))),
                ],
              ),

              SizedBox(height: 22.h),

              Expanded(
                child: TabBarView(controller: _tabController, children: _tabs),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> _tabs = [
    BlocProvider(
      create: (_) => StudentProjectCubit(
        status: AppProjectsStatus.pending,
        repository: sl(),
      ),
      child: const StudentProjectPending(),
    ),
    BlocProvider(
      create: (_) => StudentProjectCubit(
        status: AppProjectsStatus.approved,
        repository: sl(),
      ),
      child: const StudentProjectApproved(),
    ),
    BlocProvider(
      create: (_) => StudentProjectCubit(
        status: AppProjectsStatus.rejected,
        repository: sl(),
      ),
      child: const StudentProjectRejected(),
    ),
  ];
}
