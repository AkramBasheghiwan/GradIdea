import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/login_sup_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/login_view_bloc_consummer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginSupCubit>(),
      child: const LoginViewBlocConsumer(),
    );
  }
}
