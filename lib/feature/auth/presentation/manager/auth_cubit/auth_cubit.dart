import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
//import 'package:graduation_management_idea_system/feature/auth/data/repositories/auth_supabase_repository.dart';
//import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart'; // سطر مهم جداً
import 'package:graduation_management_idea_system/core/error/failure.dart'; // سطر مهم جداً
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthSupabaseRepo authRepository;

  // حذفنا الـ Object object اللي كان مسبب مشكلة في الـ Injection
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final Either<Failure, UserEntity> result = await authRepository
        .getCurrentUser();

    result.fold(
      (Failure failure) => emit(AuthUnauthenticated()), // تحديد النوع Failure
      (UserEntity user) =>
          emit(AuthAuthenticated(user)), // تحديد النوع UserEntity
    );
  }

  // Future<void> resetPassword(String email) async {
  //   emit(AuthLoading());
  //   final Either<Failure, Unit> result = await authRepository.foregetPassword(
  //     email,
  //   );

  //   result.fold(
  //     (Failure failure) => emit(
  //       AuthError(failure.message),
  //     ), // تحديد النوع هنا يحل مشكلة الـ message
  //     (_) => emit(
  //       const AuthMessageSuccess(
  //         "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.",
  //       ),
  //     ),
  //   );
  // }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await authRepository.signOut();

    result.fold(
      (Failure failure) => emit(
        AuthError(failure.message),
      ), // تحديد النوع هنا يحل مشكلة الـ message
      (_) => emit(AuthUnauthenticated()),
    );
  }
}
