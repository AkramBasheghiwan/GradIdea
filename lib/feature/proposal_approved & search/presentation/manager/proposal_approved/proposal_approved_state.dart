import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class ProposalApprovedState {
  const ProposalApprovedState();
}

class ProposalApprovedInitial extends ProposalApprovedState {}

class ProposalApprovedLoading extends ProposalApprovedState {}

class ProposalApprovedLoaded extends ProposalApprovedState {
  final List<ProjectProposals> users;
  final int page;
  final bool hasReachedMax;

  ProposalApprovedLoaded({
    required this.users,
    required this.page,
    required this.hasReachedMax,
  });

  ProposalApprovedLoaded copyWith({
    List<ProjectProposals>? users,
    int? page,
    bool? hasReachedMax,
  }) {
    return ProposalApprovedLoaded(
      users: users ?? this.users,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProposalApprovedError extends ProposalApprovedState {
  final String message;
  ProposalApprovedError({required this.message});
}
