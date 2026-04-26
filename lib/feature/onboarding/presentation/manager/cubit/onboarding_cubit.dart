// lib/features/onboarding/presentation/cubit/onboarding_cubit.dart
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/onboarding/data/model/onboarding_model.dart';
import 'package:graduation_management_idea_system/feature/onboarding/presentation/manager/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(BuildContext context) => BlocProvider.of(context);

  final PageController pageController = PageController();
  int currentIndex = 0;
  bool get isLastPage => currentIndex == items.length - 1;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  void submitOnboarding() {
    CacheHelper.saveData(key: AppConstatnce.isFirstTime, value: false).then((
      value,
    ) {
      if (value) {
        emit(OnboardingCompleted());
      }
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
