import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/verify_email_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<VerifyEmailCubit>(),
      child: const VerifyEmailViewBody(),
    );
  }
}
