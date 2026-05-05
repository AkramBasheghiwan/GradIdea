import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_icon_search_bar.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archive.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_archive_view_body.dart';

class ProjectsArchiveView extends StatelessWidget {
  const ProjectsArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          title: Text(
            'استكشف المشاريع السابقه',
            style: AppTextStyle.headline24BoldStyle,
          ),
          centerTitle: false,
          actions: [BuildIconSearchBar(onpressed: () {})],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.h),
              const CustomBulidTabBar(
                tap: <Tab>[
                  Tab(
                    child: Text(
                      'تقنية معلومات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'علوم حاسوب',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'امن معلومات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProjectsArchiveCubit(sl(), 'IT');
                        return cubit;
                      },

                      child: const ProjectsArchiveScreen(),
                    ),
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProjectsArchiveCubit(sl(), 'IS');

                        return cubit;
                      },

                      child: const ProjectsArchiveScreen(),
                    ),
                    BlocProvider(
                      lazy: true,
                      create: (BuildContext context) {
                        final cubit = ProjectsArchiveCubit(sl(), 'CS');

                        return cubit;
                      },

                      child: const ProjectsArchiveScreen(),
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
