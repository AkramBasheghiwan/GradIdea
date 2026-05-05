import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class HodProjectsState extends Equatable {
  const HodProjectsState();

  @override
  List<Object?> get props => [];
}

class HodProjectsInitial extends HodProjectsState {}

class HodProjectsLoading extends HodProjectsState {}

class HodProjectsLoaded extends HodProjectsState {
  final List<ProjectEntity> projects;
  const HodProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

class HodProjectsError extends HodProjectsState {
  final String message;
  const HodProjectsError(this.message);

  @override
  List<Object?> get props => [message];
}

class HodProjectsActionSuccess extends HodProjectsState {
  final String message;
  const HodProjectsActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
