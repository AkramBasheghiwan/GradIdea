import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      child: const ProfileViewBody(),
    );
  }
}
