// features/splash/view/splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/view/widgets/splash_view_bods.dart';

import '../../manager/cubit/splash_state.dart';

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
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardStudent);
          } else if (state.role == AppRoles.headOfDepartment) {
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardAdmin);
          } else if (state.role == AppRoles.admin) {
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardAdmin);
          }
        }
      },
      child: const SplashViewBody(),
    );
  }
}
