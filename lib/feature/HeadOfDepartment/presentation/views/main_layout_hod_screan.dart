import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/widgets/show_dialog_function.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profile_view.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/hod_get_my_projects_view.dart';
import 'package:iconsax/iconsax.dart';

import 'package:graduation_management_idea_system/core/widgets/buid_nav_bar_item.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_floating_nav_bar.dart';

import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/hod_home_view.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/hod_review_projects_view.dart';
// import 'package:graduation_management_idea_system/feature/proposal_approved & search/presentation/view/supervisor_proposal_approved.dart';

class MainLayoutHODScreen extends StatefulWidget {
  const MainLayoutHODScreen({super.key});

  @override
  State<MainLayoutHODScreen> createState() => _MainLayoutHODScreenState();
}

class _MainLayoutHODScreenState extends State<MainLayoutHODScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardAnalysisView(),
    HodReviewProjectsView(),
    HodGetMyProjectsView(),

    ProfileView(),
  ];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // يمنع الخروج التلقائي
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        ShowDialogFunction.showAppDialog(
          context: context,
          title: "تأكيد الخروج",
          description: "هل تريد الخروج من التطبيق؟",
          confirmText: "خروج",
          icon: Iconsax.logout,
          confirmColor: AppColor.primaryColor,
          onConfirm: () {
            SystemNavigator.pop(); // أو SystemNavigator.pop();
          },
        );
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: CustomFloatingNavBar(
          childern: [
            BuildNavBarItem(
              onTap: onTap,
              currentIndex: _currentIndex,
              index: 0,
              title: "الرئيسية",
              icon: Iconsax.home_2,
              activeIcon: Iconsax.home_15,
            ),

            BuildNavBarItem(
              onTap: onTap,
              currentIndex: _currentIndex,
              index: 1,
              title: "مراجعة",
              icon: Iconsax.task_square,
              activeIcon: Iconsax.task5,
            ),

            BuildNavBarItem(
              onTap: onTap,
              currentIndex: _currentIndex,
              index: 2,
              title: "مشاريعي",
              icon: Iconsax.archive,
              activeIcon: Iconsax.archive_15,
            ),

            // BuildNavBarItem(
            //   onTap: onTap,
            //   currentIndex: _currentIndex,
            //   index: 2,
            //   title: "المقترحات",
            //   icon: Iconsax.note_favorite,
            //   activeIcon: Iconsax.note_21,
            // ),
            BuildNavBarItem(
              onTap: onTap,
              currentIndex: _currentIndex,
              index: 3,
              title: "حسابي",
              icon: Iconsax.user,
              activeIcon: Iconsax.profile_circle5,
            ),
          ],
        ),
      ),
    );
  }
}
// create or replace function get_projects_proposals_stats()
// returns json
// language sql
// as $$
//   select json_build_object(
//     'total', count(*),

//     'pending', count(*) filter (where status = 'pending'),

//     'approved', count(*) filter (where status = 'approved'),

//     'rejected', count(*) filter (where status = 'rejected')
//   )
//   from project_groups;
// $$;
