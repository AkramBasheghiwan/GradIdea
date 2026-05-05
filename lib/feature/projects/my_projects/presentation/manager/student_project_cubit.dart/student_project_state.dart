import 'package:equatable/equatable.dart';

import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class StudentProjectState extends Equatable {
  const StudentProjectState();

  @override
  List<Object?> get props => [];
}

class StudentProjectInitial extends StudentProjectState {}

class StudentProjectLoading extends StudentProjectState {}

class StudentProjectLoaded extends StudentProjectState {
  final List<ProjectEntity> proposals;
  const StudentProjectLoaded(this.proposals);

  @override
  List<Object?> get props => [proposals];
}

class StudentProjectError extends StudentProjectState {
  final String message;
  const StudentProjectError(this.message);

  @override
  List<Object?> get props => [message];
}

class StudentProjectActionSuccess extends StudentProjectState {
  final String message;
  const StudentProjectActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
