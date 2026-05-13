import 'package:graduation_management_idea_system/feature/onboarding/data/model/onboarding_model.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/widgets/onboarding_build_dots.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/widgets/onboarding_build_illustration.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/view/widgets/onboarding_build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dimens.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core//utils/app_text_style.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingCubit cubit = BlocProvider.of<OnboardingCubit>(context);
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.65,
            child: PageView.builder(
              controller: cubit.pageController,
              itemCount: items.length,
              onPageChanged: context.watch<OnboardingCubit>().onPageChanged,
              //  (index) =>
              //     setState(() => _currentIndex = index),
              itemBuilder: (BuildContext context, int index) {
                return OnboardingBuildIllustration(item: items[index]);
              },
            ),
          ),
          // 2. الجزء السفلي: الحاوية البيضاء (White Card)
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.6,
            ),
            child:
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.p24.w),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OnboardingBuildText(currentIndex: cubit.currentIndex),
                      SizedBox(height: AppDimens.p32.h),
                      _buildBottomControls(context),
                    ],
                  ),
                ).animate().slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),
          ),

          if (!cubit.isLastPage) ...[
            Positioned(
              top: 50.h,
              right: AppDimens.p20.w,
              child: TextButton(
                onPressed: () {
                  cubit.submitOnboarding();
                },
                child: Text(AppStrings.skip, style: AppTextStyle.skipButton),
              ),
            ).animate().fadeIn(delay: 400.ms),
          ],
        ],
      ),
    );
  }

  // التحكم (Dots & Button)
  Widget _buildBottomControls(BuildContext context) {
    final OnboardingCubit cubit = OnboardingCubit.get(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cubit.isLastPage
            ? Expanded(
                child: ElevatedButton(
                  onPressed: context.read<OnboardingCubit>().submitOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    minimumSize: Size(
                      double.infinity,
                      AppDimens.nextButtonSize.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimens.mainButtonRadius.r,
                      ),
                    ),
                  ),
                  child: Text(
                    AppStrings.startNow,
                    style: AppTextStyle.mainButtonText,
                  ),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutQuad),
              )
            : Row(
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                  // المؤشرات (Dots)
                  ...List.generate(
                    items.length,
                    (int index) => OnboardingBuildDots(
                      index: index,
                      currentIndex: context
                          .read<OnboardingCubit>()
                          .currentIndex,
                    ),
                  ),
                ],
              ),

        if (!cubit.isLastPage)
          GestureDetector(
            onTap: () {
              cubit.pageController.nextPage(
                duration: 500.ms,
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: 60.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'التالي',
                    style: AppTextStyle.medium(16, color: AppColor.white),
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
      ],
    );
  }
}
