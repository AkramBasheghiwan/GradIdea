import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';

import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_password_new_screan_body.dart';

class ForgetpasswordNewEmail extends StatelessWidget {
  const ForgetpasswordNewEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubits>(),
      child: const ForgotPasswordNewViewBody(),
    );
  }
}
