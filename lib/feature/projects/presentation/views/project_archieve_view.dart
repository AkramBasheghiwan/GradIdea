import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_icon_search_bar.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';

import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archive.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_archive_view_body.dart';

import 'package:iconsax/iconsax.dart';

class ProjectsArchiveView extends StatelessWidget {
  const ProjectsArchiveView({super.key});

  static const List<_DepartmentTab> _departments = [
    _DepartmentTab(code: 'IT', title: 'تقنية معلومات'),
    _DepartmentTab(code: 'CS', title: 'علوم حاسوب'),
    _DepartmentTab(code: 'IS', title: 'أمن معلومات'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _departments.length,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              /// Hero Section
              _buildHeroSection(),

              SizedBox(height: 24.h),

              /// Tabs
              CustomBulidTabBar(
                tap: _departments
                    .map(
                      (dept) => Tab(
                        child: Text(
                          dept.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              SizedBox(height: 20.h),

              /// Content
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: _departments
                      .map(
                        (dept) => BlocProvider(
                          create: (_) => ProjectsArchiveCubit(
                            sl<ProjectsRepository>(),
                            dept.code,
                          ),
                          child: const ProjectsArchiveScreen(),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 20.w,
      title: Text(
        "أرشيف المشاريع",
        style: AppTextStyle.headline24BoldStyle.copyWith(
          fontSize: 24.sp,
          color: AppColor.textPrimary,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: BuildIconSearchBar(
            onpressed: () {
              Navigator.pushNamed(context, AppRoutes.searchProjects);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .22),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .15),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.archive_book, color: Colors.white, size: 28.sp),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "استكشف المشاريع السابقة",
                  style: AppTextStyle.bold(18, color: Colors.white),
                ),

                SizedBox(height: 8.h),

                Text(
                  "تصفح مشاريع التخرج السابقة، استلهم أفكاراً جديدة، وابحث بسهولة عن المشاريع حسب القسم.",
                  style: AppTextStyle.medium(
                    12,
                    color: Colors.white.withValues(alpha: .92),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DepartmentTab {
  final String code;
  final String title;

  const _DepartmentTab({required this.code, required this.title});
}
