import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/data/model/projects_status_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final ProjectStatsModel stats;

  DashboardLoaded(this.stats);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
