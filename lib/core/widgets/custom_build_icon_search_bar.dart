import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

class BuildIconSearchBar extends StatelessWidget {
  final void Function()? onpressed;
  const BuildIconSearchBar({required this.onpressed, super.key});

  @override
  Widget build(BuildContext context) {
    return
    // أيقونة البحث مع أنيميشن بسيط
    Padding(
      padding: EdgeInsets.only(left: 16.w),
      child:
          IconButton(
                onPressed: onpressed,
                icon: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black12, blurRadius: 10.r),
                    ],
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: AppColor.primaryColor,
                    size: 24.r,
                  ),
                ),
              )
              .animate(onPlay: (AnimationController c) => c.repeat())
              .shimmer(delay: 3.seconds, duration: 1.seconds),
    );
  }
}
