import 'package:graduation_management_idea_system/core/utils/images_assests.dart';

import '../../../../core/utils/app_strings.dart';

class OnboardingModel {
  final String title;
  final String body;
  final String image;

  OnboardingModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

// قائمة البيانات بناءً على كلاس AppStrings
final List<OnboardingModel> items = <OnboardingModel>[
  OnboardingModel(
    title: AppStrings.onBoardingTitle1,
    body: AppStrings.onBoardingDesc1,
    image: AppImageAssets.onboarding1,
  ),
  OnboardingModel(
    title: AppStrings.onBoardingTitle2,
    body: AppStrings.onBoardingDesc2,
    image: AppImageAssets.onboarding2,
  ),
  OnboardingModel(
    title: AppStrings.onBoardingTitle3,
    body: AppStrings.onBoardingDesc3,
    image: AppImageAssets.onboarding3,
  ),
];
