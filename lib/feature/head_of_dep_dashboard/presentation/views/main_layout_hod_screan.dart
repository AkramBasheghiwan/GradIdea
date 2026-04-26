import 'package:graduation_management_idea_system/core/widgets/buid_nav_bar_item.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/user_view.dart';

class MainLayoutHODScreen extends StatefulWidget {
  const MainLayoutHODScreen({super.key});

  @override
  State<MainLayoutHODScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutHODScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = <Widget>[
    const UserView(), // 0
    const PlaceholderScreen(title: "صفحة الإعدادات"), // 2
    const PlaceholderScreen(title: "الملف الشخصي"), // 3
  ];

  onTap(int index) {
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
            title: "المحادثات",
            icon: Icons.chat_bubble_outline_rounded,
            activeIcon: Icons.chat_bubble_rounded,
          ),

          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 1,
            title: "جهات الاتصال",
            icon: Icons.people_outline_rounded,
            activeIcon: Icons.people_alt_rounded,
          ),
          // 2: الإعدادات
          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 2,
            title: "الإعدادات",
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings_rounded,
          ),
          // 3: الملف الشخصي (باستخدام صورة)
          BuildNavBarItem(
            onTap: onTap,
            currentIndex: _currentIndex,
            index: 3,
            title: "الملف الشخصي",
            isAvatar: true,
            avatarUrl:
                "https://i.pravatar.cc/150?u=profile", // رابط صورة تجريبية
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
