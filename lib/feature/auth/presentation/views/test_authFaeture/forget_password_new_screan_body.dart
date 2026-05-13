import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';

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
      backgroundColor: const Color(0xFFF8F9FE),
      body: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            _showSnackBar(state.message, Colors.red);
          } else if (state is ForgotPasswordPasswordUpdated) {
            _showSnackBar('تم تغيير كلمة المرور بنجاح 🎉', Colors.green);

            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// 🔹 Header
                  _buildHeader(),

                  const SizedBox(height: 40),

                  /// 🔹 Card Form
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /// Password
                            _buildPasswordField(),

                            const SizedBox(height: 20),

                            /// Confirm
                            _buildConfirmPasswordField(),

                            const SizedBox(height: 30),

                            /// Button
                            _buildButton(state),
                          ],
                        ),
                      ),
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

  /// 🔥 Header جميل
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFE8EAF6),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_reset,
            size: 40,
            color: Color(0xFF4C4DDC),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'كلمة مرور جديدة',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'أنشئ كلمة مرور قوية وآمنة لحسابك',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  /// 🔒 Password Field
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'كلمة المرور الجديدة',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
        }
        return null;
      },
    );
  }

  /// 🔒 Confirm Field
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'تأكيد كلمة المرور',
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value != _passwordController.text) {
          return 'كلمتا المرور غير متطابقتين';
        }
        return null;
      },
    );
  }

  /// 🚀 Button
  Widget _buildButton(ForgotPasswordStates state) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: state is ForgotPasswordLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  context.read<ForgotPasswordCubits>().updatePassword(
                    _passwordController.text,
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C4DDC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: state is ForgotPasswordLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'حفظ كلمة المرور',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
