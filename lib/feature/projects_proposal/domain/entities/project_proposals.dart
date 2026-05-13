import 'dart:io';

import 'package:equatable/equatable.dart';

class ProjectProposals extends Equatable {
  final String? id;
  final String idSupervisor;
  final String idLeader;
  final String name;
  final String description;
  final String supervisor;
  final List<String> students;
  final String department;
  final int year;
  final File? projectFile;
  final String? fileUrl;
  final String? status;
  final String? rejectionReason;

  const ProjectProposals({
    this.id,
    required this.idSupervisor,
    required this.idLeader,
    required this.name,
    required this.description,
    required this.supervisor,
    required this.students,
    required this.department,
    required this.year,
    this.projectFile,
    this.fileUrl,
    this.status,
    this.rejectionReason,
  });

  @override
  List<Object?> get props => [
    id,
    idSupervisor,
    idLeader,
    name,
    description,
    supervisor,
    students,
    department,
    year,
    fileUrl,
    status,
    rejectionReason,
  ];
}
