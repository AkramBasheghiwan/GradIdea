import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/sign_upcubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/signup_hr_bloc_conumer.dart';

class SignupHrView extends StatelessWidget {
  const SignupHrView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SingUpCubit>(),
      child: const SignUpUserViewBlocConsumer(),
    );
  }
}
