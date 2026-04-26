import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_state.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/verify_email_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailBlocListner extends StatelessWidget {
  const VerifyEmailBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listener: (BuildContext context, VerifyEmailState state) {
        if (state is VerifyEmailMessageSuccess) {
          AppSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
        if (state is VerifyEmailSuccess) {
          AppSnackBar.show(
            context: context,
            message: "تم التحقق من البريد الإلكتروني",
            type: SnackBarType.success,
          );

          Navigator.pushReplacementNamed(context, AppRoutes.mapperView);
        } else if (state is VerifyEmailFailure && state.isOffline!) {
          AppSnackBar.show(
            context: context,
            message: state.errMessage,
            type: SnackBarType.error,
          );
        }
      },
      child: const VerifyEmailViewBody(),
    );
  }
}
