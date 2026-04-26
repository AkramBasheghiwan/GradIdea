import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/forgotPasswordCubit/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordCubit({required this.authRepository})
    : super(ForgotPasswordInitial());

  void sendCode(String email) async {
    emit(ForgotPasswordLoading());
    final Either<Failure, Unit> result = await authRepository.foregetPassword(
      email,
    );

    result.fold(
      (Failure failure) => emit(ForgotPasswordError(failure.message)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }
}
