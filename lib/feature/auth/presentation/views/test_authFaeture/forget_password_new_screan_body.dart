import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_auth_text_field.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_build_button.dart';

class ForgotPasswordNewViewBody extends StatefulWidget {
  const ForgotPasswordNewViewBody({super.key});

  @override
  State<ForgotPasswordNewViewBody> createState() =>
      _ForgotPasswordNewViewBodyState();
}

class _ForgotPasswordNewViewBodyState extends State<ForgotPasswordNewViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('كلمة مرور جديدة')),
      body: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ForgotPasswordPasswordUpdated) {
            // تم بنجاح! نظهر رسالة ونعيده لشاشة تسجيل الدخول ونحذف كل الشاشات السابقة
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم تغيير كلمة المرور بنجاح! يمكنك الآن تسجيل الدخول.',
                ),
                backgroundColor: Colors.green,
              ),
            );
            // استخدم اسم مسار شاشة تسجيل الدخول الخاص بك هنا
            // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

            // أو باستخدام popUntil إذا كانت شاشة الدخول هي الأولى
            Navigator.of(context).popUntil((route) => route.isFirst);
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
                    'الرجاء إدخال كلمة المرور الجديدة الخاصة بك.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  CustomAuthTextField(
                    controller: _passwordController,
                    hintText: 'كلمة المرور الجديدة',
                    label: 'كلمة المرور الجديدة',
                    prefixIcon: Icons.lock,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.activeColor,
                      ),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  CustomAuthTextField(
                    controller: _confirmPasswordController,
                    hintText: 'تأكيد كلمة المرور',
                    label: 'تأكيد كلمة المرور',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.activeColor,
                      ),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'كلمتا المرور غير متطابقتين';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  BuildMainButton(
                    onPressed: state is ForgotPasswordLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ForgotPasswordCubits>()
                                  .updatePassword(_passwordController.text);
                            }
                          },
                    backgroundColor: AppColor.primaryColor,
                    nameTextButton: 'حفظ كلمة المرور',
                    isLoadig: state is ForgotPasswordLoading,
                    shodowColor: AppColor.containerShadow,
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
