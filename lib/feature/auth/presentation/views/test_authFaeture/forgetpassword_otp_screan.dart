import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_password_new_screan_body.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forgetpassword_new_email.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final String email; // نحتاج الإيميل لإرساله للـ Cubit

  const ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
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
      appBar: AppBar(title: const Text('تحقق من الرمز')),
      body: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ForgotPasswordCodeVerified) {
            // الانتقال لشاشة كلمة المرور الجديدة
            Navigator.pushReplacement(
              // نستخدم Replacement عشان ما يرجع لشاشة الـ OTP
              context,
              MaterialPageRoute(
                builder: (context) => const ForgetpasswordNewEmail(),
              ),
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
                children: [
                  Text(
                    'تم إرسال رمز التحقق إلى:\n${widget.email}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6, // طول الرمز المعتاد في Supabase
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
                    onPressed: state is ForgotPasswordLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ForgotPasswordCubits>().verifyCode(
                                email: widget.email,
                                otp: _otpController.text.trim(),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: state is ForgotPasswordLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('تحقق', style: TextStyle(fontSize: 18)),
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
