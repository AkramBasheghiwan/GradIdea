import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/build_header_profile.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/build_list_title_card.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/build_logout_button.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/build_profile_action_card.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/build_profile_hero_card.dart';
import 'package:iconsax/iconsax.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              final user = state.user;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),

                child: Column(
                  children: [
                    const ProfileHeader(),

                    SizedBox(height: 24.h),

                    ProfileHeroCard(
                      user: user,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editeProfile,
                          arguments: user,
                        );
                      },
                    ),

                    SizedBox(height: 24.h),

                    // const ProfileActionCard(
                    //   title: "مشاريعي",
                    //   subtitle: "عرض مشاريع التخرج المرفوعة",
                    //   icon: Iconsax.folder_open,
                    //   count: "",
                    //   color: AppColor.cardPurple,
                    // ),

                    // SizedBox(height: 16.h),

                    // const ProfileActionCard(
                    //   title: "اقتراحاتي",
                    //   subtitle: "الأفكار والمقترحات المقدمة",
                    //   icon: Iconsax.lamp_charge,
                    //   count: "",
                    //   color: AppColor.cardBlue,
                    // ),

                    // SizedBox(height: 22.h),
                    if (CacheHelper.getData(key: AppConstatnce.getRole) ==
                        AppRoles.admin) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.appSetting);
                        },
                        child: const BuildListTitleCard(
                          title: "الإعدادات",
                          icon: Iconsax.setting_2,
                        ),
                      ),
                    ],

                    SizedBox(height: 14.h),

                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notifications);
                      },
                      child: const BuildListTitleCard(
                        title: "الإشعارات",
                        icon: Iconsax.notification,
                      ),
                    ),

                    SizedBox(height: 14.h),

                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.privacypolicy);
                      },
                      child: const BuildListTitleCard(
                        title: "الخصوصية والأمان",
                        icon: Iconsax.shield_tick,
                      ),
                    ),

                    SizedBox(height: 26.h),

                    LogoutButton(
                      onTap: () {
                        context.read<AuthCubit>().signOut();
                      },
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              );
            }

            /// loading / fallback
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
