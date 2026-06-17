import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/datasource/dashboard_analysis.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/manager/dashboard_analysis_state.dart';

class DashboardAnalysisCubit extends Cubit<DashboardAnalysisState> {
  final DashboardAnalysisRemoteDataSource dataSource;

  DashboardAnalysisCubit(this.dataSource) : super(DashboardAnalysisInitial());

  Future<void> fetchDashboardData() async {
    emit(DashboardAnalysisLoading());
    try {
      final data = await dataSource.fetchDashboardAnalysis();
      emit(DashboardAnalysisLoaded(dashboardAnalysis: data));
    } on ServerException catch (e) {
      emit(DashboardAnalysisError(message: e.message));
    } catch (e) {
      emit(
        const DashboardAnalysisError(
          message: 'حدث خطأ غير متوقع. يرجى المحاولة لاحقاً.',
        ),
      );
    }
  }
}
