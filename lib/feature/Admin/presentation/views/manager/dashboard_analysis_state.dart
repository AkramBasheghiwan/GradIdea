import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/model/dashboard_analysis_modle.dart';

class DashboardAnalysisState extends Equatable {
  const DashboardAnalysisState();
  @override
  List<Object?> get props => [];
}

class DashboardAnalysisInitial extends DashboardAnalysisState {}

class DashboardAnalysisLoading extends DashboardAnalysisState {}

class DashboardAnalysisLoaded extends DashboardAnalysisState {
  final DashboardAnalysisModle dashboardAnalysis;

  const DashboardAnalysisLoaded({required this.dashboardAnalysis});
  @override
  List<Object?> get props => [dashboardAnalysis];
}

class DashboardAnalysisError extends DashboardAnalysisState {
  final String message;

  const DashboardAnalysisError({required this.message});

  @override
  List<Object?> get props => [message];
}
