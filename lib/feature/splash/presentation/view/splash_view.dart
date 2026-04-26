import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/view/widgets/splash_view_bloc_listner.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SplashCubit>()..decideNextRoute(),
      child: const SplashViewBlocListner(),
    );
  }
}
