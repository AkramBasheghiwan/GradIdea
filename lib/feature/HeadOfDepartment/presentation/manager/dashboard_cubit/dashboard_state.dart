import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/domain/head_repo/hod_dash_repository.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/presentation/manager/dashboard_cubit/dashboard_cubit.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final HodDashRepository repo;

  DashboardCubit(this.repo) : super(DashboardInitial());

  Future<void> loadStats() async {
    emit(DashboardLoading());

    try {
      final stats = await repo.getStats();
      emit(DashboardLoaded(stats));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
