import 'package:equatable/equatable.dart';

class ProjectGroupEntity extends Equatable {
  final int id;
  final String leaderId;
  final String leaderName;
  final String supervisorId;
  final String projectTitle;
  final String projectDescription;
  final String
  status; // 'pending', AppProjectsStatus.approved, AppProjectsStatus.rejected
  final String? rejectionReason;
  final DateTime createdAt;

  const ProjectGroupEntity({
    required this.id,
    required this.leaderId,
    required this.leaderName,
    required this.supervisorId,
    required this.projectTitle,
    required this.projectDescription,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    leaderId,
    leaderName,
    supervisorId,
    projectTitle,
    projectDescription,
    status,
    rejectionReason,
    createdAt,
  ];
}
