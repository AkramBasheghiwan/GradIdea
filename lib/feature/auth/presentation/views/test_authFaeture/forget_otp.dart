import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forgetpassword_otp_screan.dart';

class Forgetotp extends StatelessWidget {
  final String email;
  const Forgetotp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubits>(),
      child: ForgotPasswordOtpScreen(email: email),
    );
  }
}
