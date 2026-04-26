// splash_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/splash/presentation/manager/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;
  SplashCubit({required this.authRepository}) : super(SplashInitial());

  Future<void> decideNextRoute() async {
    await Future.delayed(const Duration(seconds: 5));

    try {
      CacheHelper.clearData();
      final bool hasSeenOnboarding =
          CacheHelper.getData(key: AppConstatnce.isFirstTime) ?? true;
      if (hasSeenOnboarding) {
        emit(NavigateToOnboarding());
      }
      final user = await authRepository.getCurrentUser();
      user.fold(
        (failure) => {
          if (failure is OfflineFailure)
            {
              emit(
                const SplashError(
                  "No internet connection. Please check your connection and try again.",
                ),
              ),
            }
          else
            {emit(SplashError(failure.message))},
        },
        (user) {
          if (user.isEmailVerified) {
            emit(NavigateToHome(user.role));
          } else {
            emit(NavigateToEmailVerification());
          }
        },
      );
    } catch (e) {
      emit(NavigateToAuth());
    }
  }
}
