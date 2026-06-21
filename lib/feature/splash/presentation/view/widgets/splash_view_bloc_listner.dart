// features/splash/view/splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/manager/cubit/splash_state.dart';
import 'package:graduation_management_idea_system/feature/Splash/presentation/view/widgets/splash_view_bods.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/views/widgets/custom_build_project_error_card.dart';

class SplashViewBlocListner extends StatelessWidget {
  const SplashViewBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is NavigateToOnboarding) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
        } else if (state is NavigateToAuth) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        } else if (state is NavigateToEmailVerification) {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.verifyEmail,
            arguments: state.message,
          );
        } else if (state is NavigateToHome) {
          Navigator.pushReplacementNamed(context, AppRoutes.mapperView);
        }
      },
      builder: (context, state) {
        if (state is SplashError) {
          return Scaffold(
            backgroundColor: AppColor.background,
            body: Center(
              child: CustomBuildProjectErrorCard(
                message: state is SplashLoading
                    ? "اعاده التحميل ..."
                    : state.message,
                onTape: state is SplashLoading
                    ? null
                    : () {
                        context.read<SplashCubit>().decideNextRoute();
                      },
              ),
            ),
          );
        }

        return const SplashViewBody();
      },
    );
  }
}
