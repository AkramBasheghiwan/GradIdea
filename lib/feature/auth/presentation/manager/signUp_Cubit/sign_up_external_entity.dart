import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_state.dart';

import '../../../../../core/error/failure.dart';

class SignUpExternalEntityCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpExternalEntityCubit({required this.authRepository})
    : super(SignUpInitial());

  Future<void> signUpExternalEntity({
    required String name,
    required String email,
    required String password,
    required String companyName,
    required String phone,
  }) async {
    emit(SignUpLoading());

    final Either<Failure, UserEntity> result = await authRepository
        .signUpExternalEntity(
          companyName: companyName,
          phone: phone,
          name: name,
          email: email,
          password: password,
        );

    result.fold(
      (Failure failure) => emit(
        SignUpFailure(failure.message, isOffline: failure is OfflineFailure),
      ),
      (UserEntity user) => emit(SignUpSuccess(user.email)),
    );
  }
}
