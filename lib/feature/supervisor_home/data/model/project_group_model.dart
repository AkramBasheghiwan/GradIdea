import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/project_group.dart';

class ProjectGroupModel extends ProjectGroupEntity {
  const ProjectGroupModel({
    required super.id,
    required super.leaderId,
    required super.leaderName,
    required super.supervisorId,
    required super.projectTitle,
    required super.projectDescription,
    required super.status,
    super.rejectionReason,
    required super.createdAt,
  });

  factory ProjectGroupModel.fromSupabaseMap(Map<String, dynamic> map) {
    return ProjectGroupModel(
      id: map['id'] ?? 0,
      leaderId: map['leader_id'] ?? '',
      leaderName: map['leader_name'] ?? 'بدون اسم',
      supervisorId: map['supervisor_id'] ?? '',
      projectTitle: map['project_title'] ?? 'بدون عنوان',
      projectDescription: map['project_description'] ?? 'بدون وصف',
      status: map['status'] ?? 'pending',
      rejectionReason: map['rejection_reason'],
      // تحويل النص القادم من Supabase إلى كائن DateTime
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // نرسل الحقول فقط عند الإضافة (id و created_at يتم إنشاؤها تلقائياً في السيرفر)
      'leader_id': leaderId,
      'leader_name': leaderName,
      'supervisor_id': supervisorId,
      'project_title': projectTitle,
      'project_description': projectDescription,
      'status': status,
      'rejection_reason': rejectionReason,
    };
  }
}
