import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/manager/cubit/onboarding_state.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/widgets/onboarding_view_body.dart';

class OnBoardingBlocListener extends StatelessWidget {
  const OnBoardingBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (BuildContext context, OnboardingState state) {
        if (state is OnboardingCompleted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      },
      child: const OnboardingViewBody(),
    );
  }
}
