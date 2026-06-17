import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/datasource/dashboard_analysis.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/model/dashboard_analysis_modle.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/manager/dashboard_analysis_cubit.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/manager/dashboard_analysis_state.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/widgets/build_admin_header.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/widgets/custom_start_item_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/deparment_action_card.dart';
import 'package:iconsax/iconsax.dart';

class AdminDashboardHome extends StatelessWidget {
  const AdminDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardAnalysisCubit(sl<DashboardAnalysisRemoteDataSource>())
            ..fetchDashboardData(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: BlocBuilder<DashboardAnalysisCubit, DashboardAnalysisState>(
        builder: (context, state) {
          if (state is DashboardAnalysisLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }

          if (state is DashboardAnalysisLoaded) {
            final analysis = state.dashboardAnalysis;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 12.h,
                  bottom: 120.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BuildAdminHeader(),

                    SizedBox(height: 24.h),
                    _buildSectionTitle('نظرة عامة على النظام', trailing: ""),
                    SizedBox(height: 16.h),
                    _buildMainStatCard(analysis: analysis),

                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: AppStrings.deptHeads,
                            value: "12",
                            icon: Iconsax.profile_2user,
                            iconColor: AppColor.primaryColor,
                            bgColor: AppColor.activeColor.withValues(
                              alpha: 0.30,
                            ),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        Expanded(
                          child: StatCard(
                            title: AppStrings.archivedProjects,
                            value: analysis.totalCount.toString(),
                            icon: Iconsax.archive_book,
                            iconColor: AppColor.textSecondary,
                            bgColor: AppColor.primaryColor.withValues(
                              alpha: 0.30,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    _buildSectionTitle(AppStrings.quickControl),

                    SizedBox(height: 16.h),

                    DepartmentActionCard(
                      title: "استكشاف المشاريع",
                      subtitle: "تصفح جميع مشاريع القسم",
                      icon: Iconsax.folder_open,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.exploureProjects,
                        );
                      },
                    ),

                    SizedBox(height: 14.h),

                    DepartmentActionCard(
                      title: "استكشاف المقترحات",
                      subtitle: "عرض ومراجعة مقترحات المشاريع",
                      icon: Iconsax.note_favorite,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.exploureProposal,
                        );
                      },
                    ),

                    SizedBox(height: 14.h),

                    DepartmentActionCard(
                      title: "رفع مشروع",
                      subtitle: "إضافة مشروع جديد للقسم",
                      icon: Iconsax.document_upload,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.uploudProject);
                      },
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
          }
          if (state is DashboardAnalysisError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyle.bold(22, color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          );
        },
      ),
    );
  }
}

Widget _buildMainStatCard({required DashboardAnalysisModle analysis}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.w),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(28.r),
      boxShadow: [
        BoxShadow(
          color: AppColor.primaryColor.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Iconsax.chart_21,
            size: 72.sp,
            color: AppColor.primaryColor.withValues(alpha: 0.08),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.people, color: AppColor.primaryColor, size: 20.sp),

                SizedBox(width: 8.w),

                Text(AppStrings.totalUsers, style: AppTextStyle.bold(18)),
              ],
            ),

            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  analysis.usersCount.toString(),
                  style: AppTextStyle.headline32BoldStyle,
                ),

                SizedBox(width: 12.w),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.activeColor.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.trend_up,
                        color: AppColor.primaryColor,
                        size: 16.sp,
                      ),

                      SizedBox(width: 4.w),

                      Text(
                        "12%",
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

            SizedBox(height: 12.h),

            Text(
              "إجمالي المستخدمين المسجلين في النظام",
              style: AppTextStyle.medium(14, color: AppColor.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, {String? trailing}) {
  return Row(
    children: [
      Expanded(child: Text(title, style: AppTextStyle.bold(20))),

      if (trailing != null && trailing.isNotEmpty)
        Text(
          trailing,
          style: AppTextStyle.bold(14, color: AppColor.primaryColor),
        ),
    ],
  );
}
