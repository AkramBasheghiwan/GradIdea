import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  Future<void> login({required String email, required String password}) async {
    log("👉 1. بدأنا تسجيل الدخول في Firebase...");
    emit(LoginLoading());

    final Either<Failure, UserEntity> result = await authRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (Failure failure) => emit(LoginFailure(message: failure.message)),
      (UserEntity user) {
        emit(LoginSuccess(user: user));
        log("✅ 3. تم جلب البيانات بنجاح!");
      },
    );
  }
}
