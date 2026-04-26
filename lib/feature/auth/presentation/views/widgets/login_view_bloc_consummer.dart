// import 'package:graduation_management_idea_system/core/routes/app_routes.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_state.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/login_sup_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/login_view_body.dart';

import '../../../../../core/widgets/custom_show_snackbar.dart';

class LoginViewBlocConsumer extends StatelessWidget {
  const LoginViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginSupCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginRequiresVerification) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.verifyEmail,
            arguments: state.email,
          );
        }
        if (state is LoginSuccess) {
          log(
            'Login successful for user: ${state.user.email}',
            name: 'LoginViewBlocConsumer',
          );
          AppSnackBar.show(
            context: context,
            message: 'تم تسجيل الدخول بنجاح',
            type: SnackBarType.success,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.mapperView);
        } else if (state is LoginFailure) {
          log('Login failed: ${state.message}', name: 'LoginViewBlocConsumer');
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },

      builder: (BuildContext context, LoginState state) {
        return LoginViewBody(isLoading: state is LoginLoading);
      },
    );
  }
}
