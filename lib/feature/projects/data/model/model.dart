import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.name,
    required super.description,
    required super.supervisor,
    required super.students,
    required super.department,
    required super.year,
    super.projectFile,
    super.id,
    super.fileUrl,
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

      if (fileUrl != null) 'fileurl': fileUrl,
      if (status != null) 'status': status,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
    };
  }

  // من قاعدة البيانات (Map) إلى التطبيق (Model)
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id']?.toString(),
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
    );
  }

  // تحويل الـ Entity القادم من طبقة الـ Domain إلى Model لرفعه للبيانات
  factory ProjectModel.fromEntity(ProjectEntity pro) {
    return ProjectModel(
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
    );
  }
}
