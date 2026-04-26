import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart'; // تأكد من اسم الملف
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/Login_Cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSupCubit extends Cubit<LoginState> {
  final AuthSupabaseRepo authRepository;

  LoginSupCubit({required this.authRepository}) : super(LoginInitial());

  static LoginSupCubit get(context) => BlocProvider.of<LoginSupCubit>(context);

  Future<void> login({required String email, required String password}) async {
    log("👉 1. بدأنا تسجيل الدخول في Supabase..."); // تم التعديل إلى Supabase

    emit(LoginLoading());
    final Either<Failure, UserEntity> result = await authRepository.login(
      email,
      password,
    );

    result.fold(
      (Failure failure) {
        log("❌ 2. فشل تسجيل الدخول: ${failure.message}");
        emit(LoginFailure(message: failure.message));
      },
      (UserEntity user) {
        if (!user.isEmailVerified) {
          log("⚠️ 3. نجح تسجيل الدخول لكن الحساب يحتاج تفعيل!");

          emit(LoginRequiresVerification(email: user.email));
        } else {
          log("✅ 3. تم جلب البيانات وتسجيل الدخول بنجاح!");
          emit(LoginSuccess(user: user));
        }
      },
    );
  }
}
