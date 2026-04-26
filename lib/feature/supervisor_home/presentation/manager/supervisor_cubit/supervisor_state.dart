import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/project_group.dart';

abstract class SupervisorProposalsState extends Equatable {
  const SupervisorProposalsState();

  @override
  List<Object?> get props => [];
}

class ProposalsInitial extends SupervisorProposalsState {}

class ProposalsLoading extends SupervisorProposalsState {}

// حالة نجاح جلب القائمة من السيرفر
class ProposalsLoaded extends SupervisorProposalsState {
  final List<ProjectGroupEntity> proposals;

  const ProposalsLoaded(this.proposals);

  @override
  List<Object?> get props => [proposals];
}

// حالة خاصة تظهر عند الضغط على زر (قبول/رفض) لمقترح معين
class ProposalActionLoading extends SupervisorProposalsState {
  final int groupId; // لنعرف أي مقترح جاري العمل عليه الآن
  const ProposalActionLoading(this.groupId);
  @override
  List<Object?> get props => [groupId];
}

// حالة نجاح العملية (الواجهة ستستمع لها وتظهر رسالة خضراء ثم تعيد جلب القائمة)
class ProposalActionSuccess extends SupervisorProposalsState {
  final String message;
  const ProposalActionSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ProposalsError extends SupervisorProposalsState {
  final String message;
  const ProposalsError(this.message);
  @override
  List<Object?> get props => [message];
}
