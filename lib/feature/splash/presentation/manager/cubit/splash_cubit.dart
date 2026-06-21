// splash_cubit.dart

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';

import 'package:graduation_management_idea_system/feature/Splash/presentation/manager/cubit/splash_state.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthSupabaseRepo authRepository;
  SplashCubit({required this.authRepository}) : super(SplashInitial());

  Future<void> decideNextRoute() async {
    await Future.delayed(const Duration(seconds: 5));

    try {
      emit(SplashLoading());
      //CacheHelper.clearData();
      final bool hasSeenOnboarding =
          CacheHelper.getData(key: AppConstatnce.isFirstTime) ?? true;
      if (hasSeenOnboarding) {
        emit(NavigateToOnboarding());
        return;
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
            {
              log("============================"),
              log(failure.message),
              log("============================"),
              emit(NavigateToAuth()),
              // emit(SplashError(failure.message)),
            },
        },
        (user) {
          if (user.isEmailVerified) {
            emit(NavigateToHome(user.role));
          } else {
            emit(NavigateToEmailVerification(user.email));
          }
        },
      );
    } catch (e) {
      emit(NavigateToAuth());
    }
  }
}
