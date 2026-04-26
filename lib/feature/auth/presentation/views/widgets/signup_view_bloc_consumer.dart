import 'package:graduation_management_idea_system/core/router/app_routes.dart';

import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_state.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/sign_upcubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/signup_user_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUserViewBlocConsumer extends StatelessWidget {
  const SignUpUserViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingUpCubit, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state is SignUpSuccess) {
          AppSnackBar.show(
            context: context,
            message: 'تم إنشاء الحساب بنجاح',
            type: SnackBarType.success,
          );
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.verifyEmail,
            arguments: state.email,
          );
        } else if (state is SignUpFailure) {
          if (state.isOffline) {
            AppSnackBar.show(
              context: context,
              message: 'لا يوجد اتصال بالإنترنت، يرجى المحاولة مرة أخرى.',
              type: SnackBarType.error,
            );
          } else {
            AppSnackBar.show(
              context: context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        }
      },
      builder: (BuildContext context, SignUpState state) {
        return SignUpUserViewBody(isLoading: state is SignUpLoading);
      },
    );
  }
}
