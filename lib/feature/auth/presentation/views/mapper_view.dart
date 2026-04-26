import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_state.dart';

import '../../../../core/router/app_routes.dart';

class MapperView extends StatefulWidget {
  const MapperView({super.key});

  @override
  State<MapperView> createState() => _MapperViewState();
}

class _MapperViewState extends State<MapperView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const MapperBlocConsummer();
  }
}

class MapperViewBody extends StatelessWidget {
  final bool isLoading;
  const MapperViewBody({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: isLoading ? const Center(child: CircularProgressIndicator()) : null,
    );
  }
}

class MapperBlocConsummer extends StatelessWidget {
  const MapperBlocConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthAuthenticated) {
          final UserEntity user = state.user;
          log(state.user.role);
          if (user.role == AppRoles.user) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.userView);
          } else if (user.role == AppRoles.headOfDepartment) {
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.dashboardAdmin);
          } else if (user.role == AppRoles.admin) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.userView);
          } else if (user.role == AppRoles.company) {
            Navigator.of(context).pushReplacementNamed('/company');
          }
        }
        if (state is AuthError) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },

      builder: (BuildContext context, AuthState state) {
        return MapperViewBody(isLoading: state is AuthLoading);
      },
    );
  }
}
