import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/foreget_passwords_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/build_card_go_back_login.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/forget_password_view_build_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/utils/images_assests.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailForgetPasswordController;

  @override
  void initState() {
    super.initState();
    emailForgetPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailForgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector لإخفاء لوحة المفاتيح عند النقر في أي مكان فارغ
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AppImageAssets.backgroundGlow,
              height: 400.h,
              fit: BoxFit.cover,
            ).animate().fadeIn(duration: 1.seconds),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const BouncingScrollPhysics(), // إضافة تأثير سحب مرن
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.h),

                    // 2. الأيقونة الـ 3D
                    Center(
                      child:
                          Image.asset(
                            AppImageAssets.forgotPasswordIllustration,
                            height: 120.h,
                          ).animate().scale(
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ),

                    SizedBox(height: 24.h),

                    // 3. العناوين
                    Text(
                          'نسيت كلمة المرور؟',
                          style: AppTextStyle.wellComeText,
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),

                    SizedBox(height: 12.h),

                    Text(
                      'لا تقلق! أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.',
                      style: AppTextStyle.subHeadline16NormalStyle.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14.sp,
                        height: 1.5, // تحسين المسافة بين السطور للقراءة
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms),

                    SizedBox(height: 40.h),

                    // 4. الحاوية البيضاء "الطافية"
                    BlocBuilder<ForgotPasswordCubits, ForgotPasswordStates>(
                      builder:
                          (BuildContext context, ForgotPasswordStates state) {
                            return ForgetPasswordViewBuildFormCard(
                              isLoading: state is ForgotPasswordLoading,
                              controller: emailForgetPasswordController,
                              onPressed: () {
                                // إغلاق الكيبورد قبل الإرسال
                                FocusScope.of(context).unfocus();

                                if (formKey.currentState!.validate()) {
                                  context.read<ForgotPasswordCubits>().sendCode(
                                    emailForgetPasswordController.text.trim(),
                                  );
                                }
                              },
                              children: <Widget>[
                                SizedBox(height: 60.h),

                                const BuildCardGoBackLogin(),
                              ],
                            );
                          },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
