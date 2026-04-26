import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';

class ValidationResultEntity {
  final bool isUnique; // هل الفكرة جديدة كلياً؟
  final List<SimilarProjectEntity>
  similarProjects; // المشاريع المشابهة (إن وجدت)
  // نص الاقتراحات من Gemini (إن وجدت)

  ValidationResultEntity({
    required this.isUnique,
    this.similarProjects = const [],
  });
}
