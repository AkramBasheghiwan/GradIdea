import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_state.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_build_button.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/router/app_routes.dart';

class VerifySignUpOtpScreen extends StatefulWidget {
  final String email;

  const VerifySignUpOtpScreen({super.key, required this.email});

  @override
  State<VerifySignUpOtpScreen> createState() => _VerifySignUpOtpScreenState();
}

class _VerifySignUpOtpScreenState extends State<VerifySignUpOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  // استخدام الـ Notifiers التي طلبتها
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(60);
  final ValueNotifier<bool> _canResendNotifier = ValueNotifier<bool>(false);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResendNotifier.value = false;
    _timerNotifier.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerNotifier.value > 0) {
        _timerNotifier.value--;
      } else {
        _canResendNotifier.value = true;
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _timerNotifier.dispose();
    _canResendNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background, // نفس خلفية الصورة
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpFailure) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is ResendOtpSuccess) {
            _showSnackBar(context, 'تم إعادة إرسال الرمز بنجاح', Colors.green);
            _startTimer();
          } else if (state is VerifyOtpSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.userView,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  _buildHeaderIcon(),
                  SizedBox(height: 32.h),
                  _buildTitleAndSubtitle(),
                  SizedBox(height: 40.h),
                  _buildOtpFields(),
                  SizedBox(height: 48.h),
                  _buildVerifyButton(state),
                  SizedBox(height: 32.h),
                  _buildResendLogic(),
                  SizedBox(height: 100.h), // مسافة قبل التذييل
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Widgets المقسمة بدقة ---

  Widget _buildHeaderIcon() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(24.r),
        decoration: const BoxDecoration(
          color: AppColor.background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.mark_email_read_rounded,
          size: 45.r,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Column(
      children: [
        Text(
          'تحقق من الرمز',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A1C1E),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'أدخل الرمز المكون من 6 أرقام المرسل إلى\nبريدك الإلكتروني',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields() {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.w, // جعلها مربعة/دائرية متساوية
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1C1E),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle, // هذا ما يجعلها دائرية تماماً كالصورة
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
          border: Border.all(color: AppColor.primaryColor, width: 1.5),
        ),
      ),
      onCompleted: (pin) => _onVerify(pin),
    );
  }

  Widget _buildVerifyButton(VerifyOtpState state) {
    return BuildMainButton(
      onPressed: state is VerifyOtpLoading
          ? null
          : () => _onVerify(_otpController.text),
      backgroundColor: AppColor.primaryColor,
      nameTextButton: 'تحقق الآن',
      isLoadig: state is VerifyOtpLoading,
      shodowColor: AppColor.containerShadow,
    );
  }

  Widget _buildResendLogic() {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _canResendNotifier,
          builder: (context, canResend, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لم يصلك الرمز؟ ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
                GestureDetector(
                  onTap: canResend
                      ? () => context.read<VerifyOtpCubit>().resendCode(
                          widget.email,
                        )
                      : null,
                  child: Text(
                    'إعادة الإرسال',
                    style: TextStyle(
                      color: canResend ? AppColor.primaryColor : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      decoration: canResend ? TextDecoration.underline : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 16.h),
        // الكبسولة الزمنية
        ValueListenableBuilder<int>(
          valueListenable: _timerNotifier,
          builder: (context, seconds, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF6).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '00:${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.access_time_filled,
                    size: 16.r,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _onVerify(String pin) {
    if (pin.length == 6) {
      context.read<VerifyOtpCubit>().verifyOtp(
        email: widget.email,
        otp: pin.trim(),
      );
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
