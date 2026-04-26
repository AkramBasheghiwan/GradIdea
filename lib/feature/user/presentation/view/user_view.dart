import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart'
    show AppRoles;
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/cubit/cubit.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_bulid_tab_bar.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_icon_search_bar.dart';

import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/user_view_bloc_buider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,

      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          title: Text(
            AppStrings.usersDirectory,
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
                      'الطالب',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "رئيس القسم",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "الجهات",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'المشرف',
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
                      create: (BuildContext context) =>
                          UsersCubit(userRepository: sl(), role: AppRoles.user)
                            ..fetchUsers(),
                      child: const UsersListViewBlocBuilder(),
                    ),
                    BlocProvider(
                      create: (BuildContext context) => UsersCubit(
                        userRepository: sl(),
                        role: AppRoles.headOfDepartment,
                      )..fetchUsers(),
                      child: const UsersListViewBlocBuilder(),
                    ),
                    BlocProvider(
                      create: (BuildContext context) => UsersCubit(
                        userRepository: sl(),
                        role: AppRoles.company,
                      )..fetchUsers(),
                      child: const UsersListViewBlocBuilder(),
                    ),
                    BlocProvider(
                      create: (BuildContext context) => UsersCubit(
                        userRepository: sl(),
                        role: AppRoles.company,
                      )..fetchUsers(),
                      child: const UsersListViewBlocBuilder(),
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
