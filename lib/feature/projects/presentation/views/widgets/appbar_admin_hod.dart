import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/custom_build_container_icon.dart';

class AppbarAdminHod extends StatelessWidget {
  const AppbarAdminHod({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "تفاصيل المشروع",
        style: AppTextStyle.bold(18, color: AppColor.white),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      actions: [
        Row(
          children: [
            CustomBuildContainerIcon(
              icon: Icons.edit_document,
              onPressed: () {},
            ),
            SizedBox(width: 8.w),
            CustomBuildContainerIcon(
              icon: Icons.delete_outline,
              color: AppColor.redColor,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
