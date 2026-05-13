import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/presentation/views/widgets/deparment_action_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/presentation/views/widgets/department_header.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/presentation/views/widgets/department_hero_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/presentation/views/widgets/department_state_gride.dart';
import 'package:iconsax/iconsax.dart';

class DepartmentHomeView extends StatelessWidget {
  const DepartmentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              const DepartmentHeader(),

              SizedBox(height: 22.h),

              const DepartmentHeroCard(),

              SizedBox(height: 24.h),

              const DepartmentStatsGrid(),

              // SizedBox(height: 24.h),

              // DepartmentActionCard(
              //   title: "مراجعة المشاريع",
              //   subtitle: "اتخاذ قرار بشأن المشاريع قيد الانتظار",
              //   icon: Iconsax.task_square,
              //   onTap: () {},
              // ),
              SizedBox(height: 14.h),

              DepartmentActionCard(
                title: "استكشاف المشاريع",
                subtitle: "تصفح جميع مشاريع القسم",
                icon: Iconsax.folder_open,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.exploureProjects);
                },
              ),

              SizedBox(height: 14.h),

              DepartmentActionCard(
                title: "رفع مشروع",
                subtitle: "إضافة مشروع جديد للقسم",
                icon: Iconsax.document_upload,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.uploudProject);
                },
              ),

              // SizedBox(height: 14.h),

              // DepartmentActionCard(
              //   title: "استكشف المقترحات",
              //   subtitle: "عرض ومراجعة مقترحات المشاريع",
              //   icon: Iconsax.note_favorite,
              //   onTap: () {
              //     Navigator.pushNamed(context, AppRoutes.exploureProposal);
              //   },
              // ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
