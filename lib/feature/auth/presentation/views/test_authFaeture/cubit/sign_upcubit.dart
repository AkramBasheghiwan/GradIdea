import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_state.dart';
import '../../../../../../core/error/failure.dart'; // تأكد من مسار ملف الـ Failure

class SingUpCubit extends Cubit<SignUpState> {
  final AuthSupabaseRepo authRepository;

  SingUpCubit({required this.authRepository}) : super(SignUpInitial());

  Future<void> signUpExternalEntity({
    required String name,
    required String email,
    required String password,
    required String companyName,
    required String phone,
  }) async {
    emit(SignUpLoading());

    final result = await authRepository.signUpCompany(
      // أو signUpCompany حسب ما سميتها في الـ Repo
      companyName: companyName,
      phone: phone,
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (Failure failure) {
        emit(
          SignUpFailure(
            failure.message,
            isOffline: failure is OfflineFailure, // حركة ممتازة منك!
          ),
        );
      },
      (res) {
        emit(
          SignUpSuccess(res),
        ); // هنا نرسل البريد الإلكتروني بدلاً من الـ UserEntity
      },
    );
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required String specialization,
  }) async {
    emit(SignUpLoading());

    final result = await authRepository.signUpUser(
      name: name,
      email: email,
      password: password,
      spcialization: specialization,
    );

    result.fold(
      (Failure failure) => emit(
        SignUpFailure(failure.message, isOffline: failure is OfflineFailure),
      ),
      (res) => emit(SignUpSuccess(res)),
    );
  }
}
