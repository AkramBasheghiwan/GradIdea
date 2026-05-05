import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

class ProjectProposalsModel extends ProjectProposals {
  const ProjectProposalsModel({
    super.id,
    required super.idSupervisor,
    required super.idLeader,
    required super.name,
    required super.description,
    required super.supervisor,
    required super.students,
    required super.department,
    required super.year,
    super.fileUrl,
    super.projectFile,
    super.status,
    super.rejectionReason,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'supervisor': supervisor,
      'students': students,
      'department': department,
      'year': year,
      'supervisor_id': idSupervisor,
      'leader_id': idLeader,
      if (fileUrl != null) 'fileurl': fileUrl,
      if (status != null) 'status': status,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
    };
  }

  factory ProjectProposalsModel.fromMap(Map<String, dynamic> map) {
    return ProjectProposalsModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      supervisor: map['supervisor'] ?? '',

      students: map['students'] != null
          ? List<String>.from(map['students'])
          : [],
      department: map['department'] ?? '',
      year: map['year']?.toInt() ?? DateTime.now().year,
      fileUrl: map['fileurl'],
      status: map['status'],
      rejectionReason: map['rejection_reason'] ?? '',
      projectFile: null,
      idSupervisor: map['supervisor_id'] ?? '',
      idLeader: map['leader_id'] ?? '',
    );
  }

  // تحويل الـ Entity القادم من طبقة الـ Domain إلى Model لرفعه للبيانات
  factory ProjectProposalsModel.fromEntity(ProjectProposals pro) {
    return ProjectProposalsModel(
      id: pro.id,
      name: pro.name,
      description: pro.description,
      supervisor: pro.supervisor,
      students: pro.students,
      department: pro.department,
      year: pro.year,
      projectFile: pro.projectFile,
      fileUrl: pro.fileUrl,
      status: pro.status,
      rejectionReason: pro.rejectionReason,
      idSupervisor: '',
      idLeader: '',
    );
  }
}
