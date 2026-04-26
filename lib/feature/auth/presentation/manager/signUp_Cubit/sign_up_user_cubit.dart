import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUserCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpUserCubit({required this.authRepository}) : super(SignUpInitial());

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required String specialization,
  }) async {
    emit(SignUpLoading());

    final Either<Failure, UserEntity> result = await authRepository.signUpUser(
      name: name,
      email: email,
      password: password,
      specialization: specialization,
    );

    result.fold(
      (Failure failure) => emit(
        SignUpFailure(failure.message, isOffline: failure is OfflineFailure),
      ),
      (UserEntity user) => emit(SignUpSuccess(user.email)),
    );
  }
}
