import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class ProjectProposalState extends Equatable {
  const ProjectProposalState();

  @override
  List<Object?> get props => [];
}

class ProjectProposalInitial extends ProjectProposalState {}

class ProjectProposalLoading extends ProjectProposalState {}

class ProjectProposalLoaded extends ProjectProposalState {
  final List<ProjectProposals> proposals;
  const ProjectProposalLoaded(this.proposals);

  @override
  List<Object?> get props => [proposals];
}

class ProjectProposalError extends ProjectProposalState {
  final String message;
  const ProjectProposalError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProjectProposalActionSuccess extends ProjectProposalState {
  final String message;
  const ProjectProposalActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
