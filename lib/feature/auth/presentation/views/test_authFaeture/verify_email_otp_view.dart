import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/verify_email_otp_view_body.dart';

class VerifyEmailOtpView extends StatelessWidget {
  final String email; // نستقبل الإيميل من شاشة الـ SignUp
  const VerifyEmailOtpView({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<VerifyOtpCubit>(), // استبدل null بإنشاء الـ Cubit الخاص بك
      child: VerifySignUpOtpScreen(email: email),
    );
  }
}
