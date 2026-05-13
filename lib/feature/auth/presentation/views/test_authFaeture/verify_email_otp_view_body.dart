import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_state.dart';
import 'package:pinput/pinput.dart'; // مكتبة ممتازة لعمل الـ OTP بدقة
import 'dart:async';

import '../../../../../core/router/app_routes.dart';

class VerifySignUpOtpScreen extends StatefulWidget {
  final String email;

  const VerifySignUpOtpScreen({super.key, required this.email});

  @override
  State<VerifySignUpOtpScreen> createState() => _VerifySignUpOtpScreenState();
}

class _VerifySignUpOtpScreenState extends State<VerifySignUpOtpScreen> {
  final _otpController = TextEditingController();
  int _start = 59;
  Timer? _timer;

  void startTimer() {
    _start = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() => timer.cancel());
      } else {
        setState(() => _start--);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // لون الخلفية الفاتح في الصورة
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpFailure) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is ResendOtpSuccess) {
            _showSnackBar(context, 'تم إعادة إرسال الرمز بنجاح', Colors.green);
            startTimer();
          } else if (state is VerifyOtpSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mapperView,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: _buildBackgroundDecoration(), // نمط المربعات في الخلفية
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  _buildHeaderIcon(),
                  SizedBox(height: 40.h),
                  _buildTextHeader(),
                  SizedBox(height: 50.h),
                  _buildOtpInput(),
                  SizedBox(height: 60.h),
                  _buildVerifyButton(state),
                  SizedBox(height: 30.h),
                  _buildResendSection(context, state),
                  const Spacer(),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Reusable Private Widgets (يمكنك نقلها لملفات مستقلة) ---

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          'assets/images/bg_pattern.png',
        ), // ضع صورة المربعات هنا
        opacity: 0.05,
        repeat: ImageRepeat.repeat,
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      padding: EdgeInsets.all(25.r),
      decoration: const BoxDecoration(
        color: Color(0xFFE8EAF6),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.mark_email_read,
        size: 40.r,
        color: const Color(0xFF3F51B5),
      ),
    );
  }

  Widget _buildTextHeader() {
    return Column(
      children: [
        Text(
          'تحقق من الرمز',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1C1E),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          'أدخل الرمز المكون من 6 أرقام المرسل إلى\nبريدك الإلكتروني',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 55.h,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r), // دائرية كما في الصورة
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    return Pinput(
      length: 6,
      controller: _otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: const Color(0xFF3F51B5)),
        ),
      ),
    );
  }

  Widget _buildVerifyButton(VerifyOtpState state) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        onPressed: state is VerifyOtpLoading ? null : _onVerifyPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C4DDC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 5,
          shadowColor: const Color(0xFF4C4DDC).withValues(alpha: 0.4),
        ),
        child: state is VerifyOtpLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'تحقق الآن',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildResendSection(BuildContext context, VerifyOtpState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('لم يصلك الرمز؟ ', style: TextStyle(color: Colors.grey[600])),
            GestureDetector(
              onTap: _start == 0
                  ? () =>
                        context.read<VerifyOtpCubit>().resendCode(widget.email)
                  : null,
              child: Text(
                'إعادة الإرسال',
                style: TextStyle(
                  color: _start == 0 ? const Color(0xFF4C4DDC) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '00:${_start.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Color(0xFF3F51B5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.access_time,
                size: 16.r,
                color: const Color(0xFF3F51B5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onVerifyPressed() {
    if (_otpController.text.length == 6) {
      context.read<VerifyOtpCubit>().verifyOtp(
        email: widget.email,
        otp: _otpController.text.trim(),
      );
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
