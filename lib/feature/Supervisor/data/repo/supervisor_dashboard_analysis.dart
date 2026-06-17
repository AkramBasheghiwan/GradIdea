import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';

import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/datasource/dashboard_analysis_supervisor_data_source.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/model/supervisor_state_analysis.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/domain/repo/supervisor_dashboard_repo.dart';

class SupervisorDashboardAnalysisImpl extends SupervisorDashboardAnalysis {
  final DashboardAnalysisSupervisorDataSource dashboarAnalusis;

  SupervisorDashboardAnalysisImpl({required this.dashboarAnalusis});
  @override
  Future<Either<Failure, SupervisorStatisticsModel>>
  getDashboardAnalysis() async {
    try {
      final resulte = await dashboarAnalusis.getDashboardAnalysisData();

      return Right(resulte);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('حدث خطا اثناء جلب الاحصائيات'));
    }
  }
}
