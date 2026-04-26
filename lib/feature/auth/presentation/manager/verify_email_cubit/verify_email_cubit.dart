import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/verify_email_cubit/verify_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepository authRepository;
  VerifyEmailCubit({required this.authRepository})
    : super(VerifyEmailInitial());

  Future<void> verifyEmail() async {
    emit(VerifyEmailLoading());
    log("👉 1. بدأناالتحقق من الايميل في Firebase...");
    final Either<Failure, Unit> result = await authRepository.verifyEmail();

    result.fold(
      (Failure failure) => emit(
        VerifyEmailFailure(
          errMessage: failure.message,
          isOffline: Failure is OfflineFailure,
        ),
      ),
      (_) {
        emit(
          VerifyEmailMessageSuccess(
            message: "تم إرسال رابط التفعيل، يرجى التحقق من بريدك.",
          ),
        );
        log("✅ 2. تم إرسال رابط التفعيل بنجاح.");
      },
    );
  }

  Future<void> checkVerifyEmail() async {
    emit(VerifyEmailLoading());

    final Either<Failure, bool> result = await authRepository
        .checkVerifyEmail();

    result.fold(
      (Failure failure) {
        emit(
          VerifyEmailFailure(
            errMessage: failure.message,
            isOffline: Failure is OfflineFailure,
          ),
        );
      },
      (bool isVerfied) {
        if (isVerfied) {
          emit(VerifyEmailSuccess());
        } else {
          emit(
            VerifyEmailFailure(
              errMessage:
                  "لم يتم تفعيل البريد الإلكتروني بعد. يرجى الضغط على الرابط المرسل إليك.",
              isOffline: false,
            ),
          );
        }
      },
    );
  }
}
