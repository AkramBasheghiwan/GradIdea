import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/domain/repo/supervisor_dashboard_repo.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/manager/dash_analysis_cubit/dash_analysis_state.dart';

class DashAnalysisCubit extends Cubit<DashAnalysisState> {
  final SupervisorDashboardAnalysis repository;

  DashAnalysisCubit({required this.repository}) : super(DashAnalysisInitial());

  Future<void> fetchDashboardData() async {
    emit(DashAnalysisLoading());

    final data = await repository.getDashboardAnalysis();

    data.fold(
      (failure) => emit(DashAnalysisError(message: failure.message)),
      (data) => emit(DashAnalysisLoaded(data: data)),
    );
  }
}
