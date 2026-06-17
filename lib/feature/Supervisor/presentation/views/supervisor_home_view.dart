import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_header.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_hero_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_state_gride.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/model/supervisor_state_analysis.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/manager/dash_analysis_cubit/dash_analysis_cubit.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/manager/dash_analysis_cubit/dash_analysis_state.dart';
import 'package:iconsax/iconsax.dart';

class SupervisorHomeView extends StatelessWidget {
  const SupervisorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashAnalysisCubit>()..fetchDashboardData(),
      child: const SupervisorHomeViewBody(),
    );
  }
}

class SupervisorHomeViewBody extends StatelessWidget {
  const SupervisorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashAnalysisCubit, DashAnalysisState>(
      builder: (context, state) {
        if (state is DashAnalysisLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashAnalysisLoaded) {
          final data = state.data;
          // استخدم البيانات لعرض المعلومات في الواجهة
          return BuildDashboardAnalysisSupervisor(data: data);
        } else if (state is DashAnalysisError) {
          return Center(child: Text('خطأ: ${state.message}'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BuildDashboardAnalysisSupervisor extends StatelessWidget {
  const BuildDashboardAnalysisSupervisor({required this.data, super.key});
  final SupervisorStatisticsModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              const CustomBuildHeaderCard(
                title: "مرحبًا، المشرف",
                subtitle: "إدارة ومراجعة المقترحات بسهولة",
                icon: Iconsax.profile_2user,
                actionIcon: Iconsax.notification,
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.secondaryColor],
                ),
              ),

              SizedBox(height: 22.h),

              const CustomBuildHeroCard(
                title: "لوحة المشرف",
                description:
                    "متابعة الفرق الطلابية واعتماد تقدم المشاريع والتقارير الأسبوعية.",
                badgeText: "Supervisor Panel",
                icon: Iconsax.profile_2user,
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.secondaryColor],
                ),
              ),

              SizedBox(height: 24.h),

              CustomBuildStateGrid(
                items: [
                  DashboardStatModel(
                    title: "قيد النظر",
                    value: data.pending.toString(),
                    icon: Iconsax.timer_1,
                    color: const Color(0xffF59E0B),
                  ),

                  DashboardStatModel(
                    title: "معتمدة",
                    value: data.approved.toString(),
                    icon: Iconsax.tick_circle,
                    color: const Color(0xff10B981),
                  ),

                  DashboardStatModel(
                    title: "مرفوضة",
                    value: data.rejected.toString(),
                    icon: Iconsax.close_circle,
                    color: const Color(0xffEF4444),
                  ),

                  DashboardStatModel(
                    title: "مقترحات",
                    value: data.totalProposals.toString(),
                    icon: Iconsax.message_question,
                    color: const Color(0xff6366F1),
                  ),
                ],
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
