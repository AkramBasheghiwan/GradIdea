import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forgetpassword_new_email.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordOtpViewBody extends StatefulWidget {
  const ForgetPasswordOtpViewBody({super.key, required this.email});

  final String email;

  @override
  State<ForgetPasswordOtpViewBody> createState() =>
      _ForgetPasswordOtpViewBodyState();
}

class _ForgetPasswordOtpViewBodyState extends State<ForgetPasswordOtpViewBody> {
  final TextEditingController _otpController = TextEditingController();

  int _start = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    setState(() {
      _start = 59;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FE),
      body: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            AppSnackBar.show(
              context: context,
              message: state.message,
              type: SnackBarType.error,
            );
            _otpController.clear();
          }

          if (state is ForgotPasswordCodeSent) {
            AppSnackBar.show(
              context: context,
              message: "تم إعادة إرسال الرمز",
              type: SnackBarType.success,
            );

            _startTimer();
          }

          if (state is ForgotPasswordCodeVerified) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ForgetpasswordNewEmail()),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffF8F9FE)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 35.h),

                    _buildHeaderIcon(),

                    SizedBox(height: 35.h),

                    _buildTextHeader(),

                    SizedBox(height: 45.h),

                    _buildOtpInput(),

                    SizedBox(height: 55.h),

                    _buildVerifyButton(state),

                    SizedBox(height: 30.h),

                    _buildResendSection(context),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      padding: EdgeInsets.all(25.r),
      decoration: const BoxDecoration(
        color: Color(0xffE8EAF6),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.lock_reset_rounded,
        color: const Color(0xff3F51B5),
        size: 42.sp,
      ),
    );
  }

  Widget _buildTextHeader() {
    return Column(
      children: [
        Text(
          "تحقق من الرمز",
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xff1A1C1E),
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          "أدخل رمز التحقق المرسل إلى\n${widget.email}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[600],
            height: 1.7,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    final theme = PinTheme(
      width: 52.w,
      height: 58.h,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 12),
        ],
      ),
    );

    return Pinput(
      controller: _otpController,
      length: 6,
      defaultPinTheme: theme,
      focusedPinTheme: theme.copyWith(
        decoration: theme.decoration!.copyWith(
          border: Border.all(color: const Color(0xff4C4DDC), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildVerifyButton(ForgotPasswordStates state) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: state is ForgotPasswordLoading ? null : _verify,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shadowColor: const Color(0xff4C4DDC).withValues(alpha: .35),
          backgroundColor: const Color(0xff4C4DDC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: state is ForgotPasswordLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                "تحقق الآن",
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildResendSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("لم يصلك الرمز؟ ", style: TextStyle(color: Colors.grey[600])),
            GestureDetector(
              onTap: _start == 0
                  ? () {
                      context.read<ForgotPasswordCubits>().sendCode(
                        widget.email,
                      );
                    }
                  : null,
              child: Text(
                "إعادة الإرسال",
                style: TextStyle(
                  color: _start == 0 ? const Color(0xff4C4DDC) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xffE8EAF6),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            "00:${_start.toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Color(0xff3F51B5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _verify() {
    if (_otpController.text.length != 6) return;

    context.read<ForgotPasswordCubits>().verifyCode(
      email: widget.email,
      otp: _otpController.text.trim(),
    );
  }
}
