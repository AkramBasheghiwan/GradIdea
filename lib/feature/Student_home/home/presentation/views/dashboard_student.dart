import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/widgets/build_dashboard_header.dart';
import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/widgets/build_horizontial_card.dart';
import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/widgets/build_nv_bar.dart';
import 'package:graduation_management_idea_system/feature/Student_home/home/presentation/views/widgets/hero_card.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      floatingActionButton: Container(
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.secondaryColor, AppColor.primaryColor],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryColor.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.add, color: Colors.white, size: 28.sp),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      bottomNavigationBar: const CustomBottomNav(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              const DashboardHeader(),

              SizedBox(height: 24.h),

              HeroCard(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.aiValidationIdea);
                },
              ),

              SizedBox(height: 26.h),

              HorizontalActionCard(
                title: "استكشف الأرشيف",
                subtitle: "تصفح المشاريع والأبحاث السابقة",
                icon: Iconsax.book_1,
                color: AppColor.cardPurple,
                chip: "",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.exploureProposal);
                },
              ),

              SizedBox(height: 16.h),

              HorizontalActionCard(
                title: "ارفع مشروعك",
                subtitle: "شارك مشروعك مع المشرفين",
                icon: Iconsax.document_upload,
                color: AppColor.cardBlue,
                chip: "",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.uploudProject);
                },
              ),

              SizedBox(height: 16.h),

              HorizontalActionCard(
                title: "ارفع مقترح المشروع",
                subtitle: "قدّم فكرة مشروعك للمراجعة",
                icon: Iconsax.edit_2,
                color: AppColor.cardMint,
                chip: "",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.uploudProposal);
                },
              ),

              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }
}
