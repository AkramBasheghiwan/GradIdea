import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class StudentProposalState extends Equatable {
  const StudentProposalState();

  @override
  List<Object?> get props => [];
}

class StudentProposalInitial extends StudentProposalState {}

class StudentProposalLoading extends StudentProposalState {}

class StudentProposalLoaded extends StudentProposalState {
  final List<ProjectProposals> proposals;
  const StudentProposalLoaded(this.proposals);

  @override
  List<Object?> get props => [proposals];
}

class StudentProposalError extends StudentProposalState {
  final String message;
  const StudentProposalError(this.message);

  @override
  List<Object?> get props => [message];
}

class StudentProposalActionSuccess extends StudentProposalState {
  final String message;
  const StudentProposalActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
