import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/sign_upcubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/signup_view_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUserView extends StatelessWidget {
  const SignUpUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SingUpCubit>(),
      child: const SignUpUserViewBlocConsumer(),
    );
  }
}
