import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profile_view.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/hod_get_my_projects_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:graduation_management_idea_system/core/widgets/buid_nav_bar_item.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_floating_nav_bar.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/dashboard_view.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/user_view.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AdminDashboardHome(),
    HodGetMyProjectsView(),
    UserView(),
    ProfileView(),
  ];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomFloatingNavBar(
        childern: [
          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 0,
            title: "لوحة التحكم",
            icon: Iconsax.element_4,
            activeIcon: Iconsax.home_15,
          ),

          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 1,
            title: "مشاريعي",
            icon: Iconsax.task_square,
            activeIcon: Iconsax.task5,
          ),

          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 2,
            title: "الاداره",
            icon: Iconsax.profile_2user4,
            activeIcon: Iconsax.profile_2user5,
          ),

          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 3,
            title: "حسابي",
            icon: Iconsax.profile_circle,
            activeIcon: Iconsax.profile_circle5,
          ),
        ],
      ),
    );
  }
}
