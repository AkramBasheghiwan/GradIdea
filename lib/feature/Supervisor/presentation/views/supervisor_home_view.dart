import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';

import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_header.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_hero_card.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/views/widgets/department_state_gride.dart';
import 'package:iconsax/iconsax.dart';

class SupervisorHomeView extends StatelessWidget {
  const SupervisorHomeView({super.key});

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
                title: "مرحبًا، المشرف",
                subtitle: "إدارة ومراجعة المقترحات بسهولة",
                icon: Iconsax.profile_2user,
                actionIcon: Iconsax.notification,
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.secondaryColor],
                ),
              ),

              SizedBox(height: 22.h),

              const CustomBuildHeroCard(
                title: "لوحة المشرف",
                description:
                    "متابعة الفرق الطلابية واعتماد تقدم المشاريع والتقارير الأسبوعية.",
                badgeText: "Supervisor Panel",
                icon: Iconsax.profile_2user,
                gradient: LinearGradient(
                  colors: [Color(0xff0EA5E9), Color(0xff06B6D4)],
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

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
