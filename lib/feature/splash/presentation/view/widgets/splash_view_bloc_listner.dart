// features/splash/view/splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/manager/cubit/splash_state.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/view/widgets/splash_view_bods.dart';

class SplashViewBlocListner extends StatelessWidget {
  const SplashViewBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is NavigateToOnboarding) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
        } else if (state is NavigateToAuth) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        } else if (state is NavigateToEmailVerification) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.verifyEmail);
        } else if (state is NavigateToHome) {
          if (state.role == AppRoles.user) {
            initStudentScope();
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardStudent);
          } else if (state.role == AppRoles.headOfDepartment) {
            initHeadOfDepartScope();
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardAdmin);
            if (state.role == AppRoles.supervisor) {
              initSupervisorScope();
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.supervisorHome);
            } else if (state.role == AppRoles.admin) {
              initAdminScope();
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.dashboardAdmin);
            }
          }
        }
      },
      child: const SplashViewBody(),
    );
  }
}
