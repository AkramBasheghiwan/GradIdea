import 'dart:async';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/utils/images_assests.dart';

class VerifyEmailViewBody extends StatefulWidget {
  const VerifyEmailViewBody({super.key});

  @override
  State<VerifyEmailViewBody> createState() => _VerifyEmailViewBodyState();
}

class _VerifyEmailViewBodyState extends State<VerifyEmailViewBody>
    with WidgetsBindingObserver {
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(60);
  final ValueNotifier<bool> _canResendNotifier = ValueNotifier<bool>(false);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _timerNotifier.dispose();
    _canResendNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<VerifyEmailCubit>().checkVerifyEmail();
    }
  }

  bool isLoading =
      false; // يمكنك ربط هذا بالحالة الحقيقية من الـ Cubit إذا أردت

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: BlocListener<VerifyEmailCubit, VerifyEmailState>(
        listener: (BuildContext context, VerifyEmailState state) {
          if (state is VerifyEmailSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is VerifyEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                AppImageAssets.backgroundGlow,
                height: 0.5.sh,
                width: double.infinity,
                fit: BoxFit.cover,
              ).animate().fadeIn(duration: 800.ms),
            ),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.h),

                        Image.asset(AppImageAssets.whiteLogo, height: 180.h)
                            .animate(
                              onPlay: (AnimationController c) =>
                                  c.repeat(reverse: true),
                            )
                            .moveY(
                              begin: -8,
                              end: 8,
                              duration: 2.seconds,
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1, 1),
                              end: const Offset(1.05, 1.05),
                            ),

                        SizedBox(height: 10.h),

                        Text(
                              AppStrings.verifyEmailTitle,
                              style: AppTextStyle.wellComeText,
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fadeIn(delay: 200.ms)
                            .slideY(begin: 0.2, end: 0),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.p32.w,
                            vertical: AppDimens.p8.h,
                          ),
                          child: Text(
                            AppStrings.verifyEmailSubTitle,
                            style: AppTextStyle.subHeadline16NormalStyle
                                .copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  height: 1.6,
                                ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 400.ms),
                        ),

                        // 3. البطاقة السفلية (تم إضافة Padding جانبي لزيادة الأناقة)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child:
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(
                                  24.w,
                                  32.h,
                                  24.w,
                                  24.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      AppDimens.bottomContainerRadius.r,
                                    ),
                                    bottom: Radius.circular(
                                      20.r,
                                    ), // تدوير خفيف من الأسفل لجمالية أكثر
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 30,
                                      offset: const Offset(0, -10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // زر التحقق
                                    BlocBuilder<
                                      VerifyEmailCubit,
                                      VerifyEmailState
                                    >(
                                      builder:
                                          (
                                            BuildContext context,
                                            VerifyEmailState state,
                                          ) {
                                            isLoading =
                                                state is VerifyEmailLoading;
                                            return ElevatedButton(
                                              onPressed: isLoading
                                                  ? null
                                                  : () => context
                                                        .read<
                                                          VerifyEmailCubit
                                                        >()
                                                        .checkVerifyEmail(),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.secondaryColor,
                                                minimumSize: Size(
                                                  double.infinity,
                                                  56.h,
                                                ),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        14.r,
                                                      ),
                                                ),
                                              ),
                                              child: isLoading
                                                  ? SizedBox(
                                                      height: 24.r,
                                                      width: 24.r,
                                                      child:
                                                          const CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2.5,
                                                          ),
                                                    )
                                                  : Text(
                                                      AppStrings.checkStatus,
                                                      style: AppTextStyle
                                                          .mainButtonText,
                                                    ),
                                            );
                                          },
                                    ),

                                    SizedBox(height: 24.h),

                                    // عداد إعادة الإرسال بتصميم أنظف
                                    ValueListenableBuilder<bool>(
                                      valueListenable: _canResendNotifier,
                                      builder:
                                          (
                                            BuildContext context,
                                            bool canResend,
                                            Widget? child,
                                          ) {
                                            return AnimatedSwitcher(
                                              duration: 300.ms,
                                              child: canResend
                                                  ? TextButton.icon(
                                                      key: const ValueKey(
                                                        'resend_btn',
                                                      ),
                                                      onPressed: isLoading
                                                          ? null
                                                          : () {
                                                              context
                                                                  .read<
                                                                    VerifyEmailCubit
                                                                  >()
                                                                  .verifyEmail();
                                                              startTimer();
                                                            },
                                                      icon: const Icon(
                                                        Icons.refresh_rounded,
                                                        size: 18,
                                                      ),
                                                      label: Text(
                                                        AppStrings.resendEmail,
                                                        style: AppTextStyle
                                                            .link14BoldStyle
                                                            .copyWith(
                                                              fontSize: 15.sp,
                                                            ),
                                                      ),
                                                    )
                                                  : ValueListenableBuilder<int>(
                                                      key: const ValueKey(
                                                        'timer_text',
                                                      ),
                                                      valueListenable:
                                                          _timerNotifier,
                                                      builder:
                                                          (
                                                            BuildContext
                                                            context,
                                                            int timerValue,
                                                            _,
                                                          ) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        16.w,
                                                                    vertical:
                                                                        8.h,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .secondaryColor
                                                                    .withValues(
                                                                      alpha:
                                                                          0.05,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20.r,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .timer_outlined,
                                                                    size: 18.r,
                                                                    color: AppColor
                                                                        .textSecondary,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.w,
                                                                  ),
                                                                  Text(
                                                                    "${AppStrings.resendAfter} $timerValue ${AppStrings.second}",
                                                                    style: AppTextStyle
                                                                        .bodyMedium
                                                                        .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                    ),
                                            );
                                          },
                                    ),

                                    SizedBox(height: 16.h),

                                    // زر العودة
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (Route route) => false,
                                          ),
                                      style: TextButton.styleFrom(
                                        minimumSize: Size(
                                          double.infinity,
                                          45.h,
                                        ),
                                        foregroundColor: Colors.grey[600],
                                      ),
                                      child: Text(
                                        AppStrings.backToLogin,
                                        style: AppTextStyle.skipButton,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().slideY(
                                begin: 0.4,
                                end: 0,
                                curve: Curves.easeOutCubic,
                                duration: 700.ms,
                              ),
                        ),
                        SizedBox(height: 10.h), // مساحة أمان سفلية
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    _timer?.cancel(); // إلغاء أي تايمر قديم فوراً
    _canResendNotifier.value = false;
    _timerNotifier.value = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_timerNotifier.value <= 0) {
        timer.cancel();
        _canResendNotifier.value = true;
      } else {
        _timerNotifier.value--;
      }
    });
  }
}
