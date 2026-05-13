import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forget_password_form_controller.dart';
import 'package:iconsax/iconsax.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_show_snackbar.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/forgetpassword_otp_view.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  late ForgetPasswordFormController controller;

  @override
  void initState() {
    controller = ForgetPasswordFormController();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordCubits, ForgotPasswordStates>(
          listener: (context, state) {
            if (state is ForgotPasswordError) {
              AppSnackBar.show(
                context: context,
                message: state.message,
                type: SnackBarType.error,
              );
            }

            if (state is ForgotPasswordCodeSent) {
              AppSnackBar.show(
                context: context,
                message: "تم إرسال رمز التحقق بنجاح",
                type: SnackBarType.success,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ForgetPasswordOtpView(
                    email: controller.emailForgetController.text.trim(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgotPasswordLoading;

            return ForgetPasswordEmailViewBody(isLoading: isLoading);
          },
        ),
      ),
    );
  }
}

class ForgetPasswordEmailViewBody extends StatefulWidget {
  final bool isLoading;

  const ForgetPasswordEmailViewBody({super.key, required this.isLoading});

  @override
  State<ForgetPasswordEmailViewBody> createState() =>
      _ForgetPasswordEmailViewBodyState();
}

class _ForgetPasswordEmailViewBodyState
    extends State<ForgetPasswordEmailViewBody> {
  // final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  late ForgetPasswordFormController controller;
  @override
  void initState() {
    controller = ForgetPasswordFormController();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    //_emailController.dispose();
    super.dispose();
  }

  void submit() {
    if (controller.validate) return;

    context.read<ForgotPasswordCubits>().sendCode(
      controller.emailForgetController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          /// Back
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Iconsax.arrow_right_3,
                color: AppColor.primaryColor,
                size: 22.sp,
              ),
            ),
          ).animate().fade().slideX(begin: .2),

          SizedBox(height: 40.h),

          /// Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 95.w,
                  height: 95.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.secondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withValues(alpha: .25),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Icon(
                    Iconsax.password_check,
                    color: Colors.white,
                    size: 42.sp,
                  ),
                ),

                SizedBox(height: 24.h),

                Text("نسيت كلمة المرور؟", style: AppTextStyle.bold(28)),

                SizedBox(height: 10.h),

                Text(
                  "أدخل بريدك الإلكتروني وسنرسل لك رمز تحقق مكوّن من 6 أرقام",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium(
                    14,
                    color: AppColor.grey,
                  ).copyWith(height: 1.7),
                ),
              ],
            ),
          ).animate().fade().slideY(begin: .2),

          SizedBox(height: 40.h),

          /// Card
          Container(
            padding: EdgeInsets.all(22.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "البريد الإلكتروني",
                      style: AppTextStyle.bold(14),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  TextFormField(
                    controller: controller.emailForgetController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.medium(14),
                    decoration: InputDecoration(
                      hintText: "example@email.com",
                      prefixIcon: Icon(
                        Iconsax.sms,
                        color: AppColor.primaryColor,
                        size: 20.sp,
                      ),
                      filled: true,
                      fillColor: AppColor.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains("@")) {
                        return "أدخل بريد إلكتروني صحيح";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 28.h),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColor.primaryColor,
                            AppColor.secondaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: ElevatedButton(
                        onPressed: widget.isLoading ? null : submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        child: widget.isLoading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.send_1,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "إرسال الرمز",
                                    style: AppTextStyle.bold(
                                      15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(delay: 200.ms).slideY(begin: .15),
        ],
      ),
    );
  }
}
