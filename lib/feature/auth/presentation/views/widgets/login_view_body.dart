import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/images_assests.dart';
import 'package:graduation_management_idea_system/core/utils/validator_manager.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/helper/show_account_bottom_sheet.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/login_sup_cubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_cubit.dart';

import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_build_button.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dimens.dart';
import '../../../../../core/utils/app_text_style.dart';

class LoginViewBody extends StatefulWidget {
  final bool isLoading;
  const LoginViewBody({required this.isLoading, super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background, // الخلفية الزرقاء العلوية
      body: Stack(
        children: <Widget>[
          // خلفية الصور الهندسية (Pattern)
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              height: 350.h,
              AppImageAssets.backgroundGlow,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 80.h), // مسافة من الأعلى
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80.h),
                // الشعار (Shield)
                Image.asset(AppImageAssets.whiteLogo, height: 140.h)
                    .animate(
                      onPlay: (AnimationController c) =>
                          c.repeat(reverse: true),
                    )
                    .moveY(
                      begin: -5,
                      end: 5,
                      duration: 2.seconds,
                      curve: Curves.easeInOut,
                    ),
                Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyle.wellComeText,
                ).animate().slideY(begin: 0.3, end: 0),

                SizedBox(height: AppDimens.p48.h),

                // الحاوية البيضاء (White Card)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  padding: EdgeInsets.all(AppDimens.p24.w),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppDimens.bottomContainerRadius.r,
                      ),
                      topRight: Radius.circular(
                        AppDimens.bottomContainerRadius.r,
                      ),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomAuthTextField(
                          validator: (value) {
                            return ValidatorManager.validateEmail(value);
                          },
                          controller: _emailController,
                          label: AppStrings.emailLabel,
                          hintText: AppString.emailHint,
                          prefixIcon: Icons.email_outlined,
                        ).animate().fadeIn(delay: 200.ms),

                        SizedBox(height: AppDimens.p20.h),

                        CustomAuthTextField(
                          validator: (value) {
                            return ValidatorManager.validatePassword(value);
                          },
                          controller: _passwordController,
                          label: AppString.password,
                          hintText: AppString.passwordHint,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: AppColor.grey,
                          ),
                        ).animate().fadeIn(delay: 400.ms),

                        SizedBox(height: AppDimens.p32.h),
                        BuildLoginButton(
                          onPressed: widget.isLoading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;
                                  context.read<LoginSupCubit>().login(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                },
                          backgroundColor: AppColor.primaryColor,
                          nameTextButton: AppString.login,
                          isLoadig: widget.isLoading,
                          shodowColor: AppColor.primaryColor.withValues(
                            alpha: 0.4,
                          ),
                        ),

                        SizedBox(height: AppDimens.p16.h),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.forgetPassword,
                            );
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppTextStyle.bodyMedium,
                          ),
                        ),

                        SizedBox(height: AppDimens.p24.h),

                        // ليس لديك حساب؟
                        SizedBox(height: AppDimens.p24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppStrings.dontHaveAccount,
                              style: AppTextStyle.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                showAccountTypeBottomSheet(context);
                              },
                              child: Text(
                                AppStrings.createAccount,
                                style: AppTextStyle.link14BoldStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).animate().slideY(begin: 0.5, end: 0, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
