import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/forget_password_view_body.dart';

class ForgotPasswordViewBlocConsummer extends StatelessWidget {
  const ForgotPasswordViewBlocConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.background,
      body: BlocListener<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (BuildContext context, ForgotPasswordStates state) {
          if (state is ForgotPasswordCodeSent) {
            AppSnackBar.show(
              context: context,
              message: 'تم إرسال رابط الاستعادة بنجاح',
              type: SnackBarType.success,
            );
            Navigator.pop(context);
          } else if (state is ForgotPasswordError) {
            AppSnackBar.show(
              context: context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        child: const ForgetPasswordViewBody(),
      ),
    );
  }
}
