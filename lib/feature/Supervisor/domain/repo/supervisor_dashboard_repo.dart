import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/model/supervisor_state_analysis.dart';

abstract class SupervisorDashboardAnalysis {
  Future<Either<Failure, SupervisorStatisticsModel>> getDashboardAnalysis();
}
