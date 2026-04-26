import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/widgets/onboarding_bloc_consummer.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnboardingCubit(),
      child: const OnBoardingBlocListener(),
    );
  }
}
