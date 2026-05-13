import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/supervisor_detail_entity.dart'; // تأكد من المسار

class SupervisorDetailsModel extends SupervisorDetailsEntity {
  const SupervisorDetailsModel({
    required super.id,
    required super.maxGroupsCount,
    required super.currentGroupsCount,
  });

  factory SupervisorDetailsModel.fromSupabaseMap(Map<String, dynamic> map) {
    return SupervisorDetailsModel(
      id: map['id'] ?? '',
      maxGroupsCount: map['max_groups_count'] ?? 5, // القيمة الافتراضية 5
      currentGroupsCount: map['current_groups_count'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'max_groups_count': maxGroupsCount,
      'current_groups_count': currentGroupsCount,
    };
  }
}
