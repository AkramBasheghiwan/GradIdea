import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class BuildAdminHeader extends StatelessWidget {
  const BuildAdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDOx_tAaZy1pE1D1yXLtnUgdMc9ukJUTKi0FbCGhHQ0r-Jg4ZrORsiDlu_5pJlLD55gltl621loWTXaQkWKihucwY0ULzHNmkuy7Qlu5IaCZvCuRtDwnyEnB22Wf-GKWR9WAVth7UD4x-6A_gShwF7rC7zFSYxiAfJhy97ZeAbYWHFjeOHxoYwhsMrjGWsyetisLKQqH1r_miyd5FAPB79SCFHXy7HmJm4Wl8Kknd17e2tSlCtGm3IZluD_1prab8il6tm0VDO3Hc4",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('مرحبا,المسئول', style: AppTextStyle.bold(16)),
                  Text('نظرة عامة للنظام', style: AppTextStyle.medium(16)),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: AppColor.textSecondary,
                  size: 24.sp,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
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
