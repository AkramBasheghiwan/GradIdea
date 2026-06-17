import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/model/supervisor_state_analysis.dart';

abstract class DashAnalysisState extends Equatable {
  const DashAnalysisState();

  @override
  List<Object> get props => [];
}

class DashAnalysisInitial extends DashAnalysisState {}

class DashAnalysisLoading extends DashAnalysisState {}

class DashAnalysisLoaded extends DashAnalysisState {
  final SupervisorStatisticsModel data;

  const DashAnalysisLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class DashAnalysisError extends DashAnalysisState {
  final String message;

  const DashAnalysisError({required this.message});

  @override
  List<Object> get props => [message];
}
