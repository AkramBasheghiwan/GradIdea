import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/user/domain/repository/user_repo.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository userRepository;
  final String role;

  UsersCubit({required this.userRepository, required this.role})
    : super(UsersInitial());
  //List<UserEntity> _currentUser = [];
  // int _currentPage = 0;
  // bool boolReachedMax = false;
  // bool _isFetchingMore = false;
  Future<void> fetchUsers() async {
    //if (state is UsersLoaded && !isRefresh) return;
    emit(UsersLoading());
    final Either<Failure, List<UserEntity>> result = await userRepository
        .getUsersByRole(role);

    result.fold(
      (Failure failure) => emit(UsersError(message: failure.message)),
      (List<UserEntity> result) => emit(UsersLoaded(users: result)),
    );
  }

  Future<String?> deleteUser(String userId) async {
    final Either<Failure, Unit> result = await userRepository.deleteUser(
      userId,
    );

    return result.fold((Failure failure) => failure.message, (_) {
      // في حال النجاح: نحذف المستخدم من القائمة المعروضة حالياً بدون جلب بيانات من النت
      if (state is UsersLoaded) {
        final UsersLoaded currentState = state as UsersLoaded;
        final List<UserEntity> updatedList = currentState.users
            .where((UserEntity user) => user.uid != userId)
            .toList();
        emit(UsersLoaded(users: updatedList)); // تحديث الشاشة فوراً
      }
      return null; // نعيد null بمعنى أنه لا يوجد خطأ (نجاح)
    });
  }

  Future<String?> changeUserRole(String userId, String newRole) async {
    final Either<Failure, Unit> result = await userRepository.updateUserRole(
      userId,
      newRole,
    );

    return result.fold((Failure failure) => failure.message, (_) {
      if (state is UsersLoaded) {
        final UsersLoaded currentState = state as UsersLoaded;
        final List<UserEntity> updatedList = currentState.users
            .where((UserEntity user) => user.uid != userId)
            .toList();
        emit(UsersLoaded(users: updatedList));
      }
      return null; // نجاح
    });
  }
}
