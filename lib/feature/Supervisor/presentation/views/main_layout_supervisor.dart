import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/widgets/show_dialog_function.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/views/supervisor_home_view.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profile_view.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/supervisor_on_proposal_approved.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/supervisor_review_proposal_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:graduation_management_idea_system/core/widgets/buid_nav_bar_item.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_floating_nav_bar.dart';

class MainLayoutSupervisor extends StatefulWidget {
  const MainLayoutSupervisor({super.key});

  @override
  State<MainLayoutSupervisor> createState() => _MainLayoutSupervisorState();
}

class _MainLayoutSupervisorState extends State<MainLayoutSupervisor> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SupervisorHomeView(),
    SupervisorReviewProposalView(),
    SupervisorOnProposalsApprovedView(),
    ProfileView(), // profile لاحقاً
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
            Navigator.pop(context); // أو SystemNavigator.pop();
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
              title: "المقترحات",
              icon: Iconsax.note_favorite,
              activeIcon: Iconsax.note_21,
            ),

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
