import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// تأكد من مسارات الاستيراد الخاصة بك

import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_state.dart';

import '../../../../../core/router/app_routes.dart';

class VerifySignUpOtpScreen extends StatefulWidget {
  final String email; // نستقبل الإيميل من شاشة الـ SignUp

  const VerifySignUpOtpScreen({super.key, required this.email});

  @override
  State<VerifySignUpOtpScreen> createState() => _VerifySignUpOtpScreenState();
}

class _VerifySignUpOtpScreenState extends State<VerifySignUpOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تأكيد الحساب')),
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpFailure) {
            // فشل التحقق أو إعادة الإرسال
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ResendOtpSuccess) {
            // نجاح إعادة إرسال الرمز
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم إعادة إرسال الرمز بنجاح. يرجى التحقق من بريدك.',
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is VerifyOtpSuccess) {
            // 🎉 نجاح التحقق من الحساب!
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تأكيد حسابك بنجاح! مرحباً بك.'),
                backgroundColor: Colors.green,
              ),
            );

            // هنا نوجه المستخدم للصفحة الرئيسية (ونحذف شاشات التسجيل من الخلفية)
            // استبدل '/home' باسم المسار الخاص بصفحتك الرئيسية
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.userView,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.mark_email_read_outlined,
                    size: 80,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'تم إرسال رمز تحقق إلى بريدك الإلكتروني:',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 10),
                    decoration: const InputDecoration(
                      labelText: 'رمز التحقق (6 أرقام)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'الرجاء إدخال الرمز المكون من 6 أرقام';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: state is VerifyOtpLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<VerifyOtpCubit>().verifyOtp(
                                email: widget.email,
                                otp: _otpController.text.trim(),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: state is VerifyOtpLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'تأكيد الحساب',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  const SizedBox(height: 20),
                  // زر إعادة إرسال الرمز
                  TextButton(
                    onPressed: state is VerifyOtpLoading
                        ? null
                        : () {
                            context.read<VerifyOtpCubit>().resendCode(
                              widget.email,
                            );
                          },
                    child: const Text('لم تستلم الرمز؟ إعادة إرسال'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
