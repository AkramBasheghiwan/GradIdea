import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/deparment_action_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_header.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_hero_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_state_gride.dart';
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
              const CustomBuildHeaderCard(
                title: "مرحبًا، رئيس القسم",
                subtitle: "متابعة واعتماد مشاريع التخرج",
                icon: Iconsax.teacher,
                actionIcon: Iconsax.notification,
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.accentBlue],
                ),
              ),

              SizedBox(height: 22.h),

              const CustomBuildHeroCard(
                title: "قسم تقنية المعلومات",
                description:
                    "إدارة المشاريع الأكاديمية ومتابعة المقترحات واعتماد المشاريع الخاصة بالقسم.",
                badgeText: "لوحة الإدارة",
                icon: Iconsax.building_3,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [AppColor.primaryColor, AppColor.secondaryColor],
                ),
              ),

              SizedBox(height: 24.h),

              const CustomBuildStateGrid(
                items: [
                  DashboardStatModel(
                    title: "قيد النظر",
                    value: "12",
                    icon: Iconsax.timer_1,
                    color: Color(0xffF59E0B),
                  ),

                  DashboardStatModel(
                    title: "معتمدة",
                    value: "31",
                    icon: Iconsax.tick_circle,
                    color: Color(0xff10B981),
                  ),

                  DashboardStatModel(
                    title: "مرفوضة",
                    value: "4",
                    icon: Iconsax.close_circle,
                    color: Color(0xffEF4444),
                  ),

                  DashboardStatModel(
                    title: "مقترحات",
                    value: "18",
                    icon: Iconsax.message_question,
                    color: Color(0xff6366F1),
                  ),
                ],
              ),

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
