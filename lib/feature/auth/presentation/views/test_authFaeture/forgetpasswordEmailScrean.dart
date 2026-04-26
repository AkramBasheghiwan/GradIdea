import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_otp.dart';

// سننشئها في الخطوة التالية

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نسيت كلمة المرور')),
      body: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ForgotPasswordCodeSent) {
            // الانتقال لشاشة الـ OTP وتمرير الإيميل
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إرسال رمز التحقق إلى بريدك الإلكتروني'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Forgetotp(email: _emailController.text.trim()),
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
                  const Text(
                    'الرجاء إدخال بريدك الإلكتروني المسجل لدينا، وسنقوم بإرسال رمز تحقق مكون من 6 أرقام.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'الرجاء إدخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: state is ForgotPasswordLoading
                        ? null // تعطيل الزر أثناء التحميل
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ForgotPasswordCubits>().sendCode(
                                _emailController.text.trim(),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: state is ForgotPasswordLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'إرسال الرمز',
                            style: TextStyle(fontSize: 18),
                          ),
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
