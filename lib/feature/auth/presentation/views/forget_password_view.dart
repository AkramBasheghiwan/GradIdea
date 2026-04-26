import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/forgot_password_view_bloc_consummer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/forgotPasswordCubit/forgot_password_cubit.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<ForgotPasswordCubits>(),
      child: const ForgotPasswordViewBlocConsummer(),
    );
  }
}
