import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/build_header_profile.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/build_list_title_card.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/build_logout_button.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/build_profile_action_card.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/build_profile_hero_card.dart';
import 'package:iconsax/iconsax.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              const ProfileHeader(),

              SizedBox(height: 24.h),

              const ProfileHeroCard(),

              SizedBox(height: 24.h),

              const ProfileActionCard(
                title: "مشاريعي",
                subtitle: "عرض مشاريع التخرج المرفوعة",
                icon: Iconsax.folder_open,
                count: "12",
                color: AppColor.cardPurple,
              ),

              SizedBox(height: 16.h),

              const ProfileActionCard(
                title: "اقتراحاتي",
                subtitle: "الأفكار والمقترحات المقدمة",
                icon: Iconsax.lamp_charge,
                count: "5",
                color: AppColor.cardBlue,
              ),

              SizedBox(height: 22.h),

              const BuildListTitleCard(
                title: "الإعدادات",
                icon: Iconsax.setting_2,
              ),

              SizedBox(height: 14.h),

              const BuildListTitleCard(
                title: "الإشعارات",
                icon: Iconsax.notification,
              ),

              SizedBox(height: 14.h),

              const BuildListTitleCard(
                title: "الخصوصية والأمان",
                icon: Iconsax.shield_tick,
              ),

              SizedBox(height: 26.h),

              const LogoutButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
