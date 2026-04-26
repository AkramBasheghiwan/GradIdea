import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

class BuildNavBarItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData? icon;
  final IconData? activeIcon;
  final bool isAvatar;
  final String? avatarUrl;
  int currentIndex;
  final Function(int) onTap;
  BuildNavBarItem({
    required this.currentIndex,
    required this.index,
    this.isAvatar = false,
    required this.title,
    this.activeIcon,
    this.icon,
    this.avatarUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h)
            : EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.activeBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                if (isAvatar)
                  CircleAvatar(
                    radius: 14.r,
                    backgroundImage: NetworkImage(avatarUrl ?? ''),
                    backgroundColor: Colors.grey[200],
                  )
                else
                  Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected
                        ? AppColor.activeColor
                        : AppColor.inactiveColor,
                    size: 26.r,
                  ),
              ],
            ),
            SizedBox(height: 4.h),

            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColor.activeColor
                    : AppColor.inactiveColor,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
