import 'package:graduation_management_idea_system/feature/HeadOfDepartment/data/model/projects_status_model.dart';

abstract class HodDashRepository {
  Future<ProjectStatsModel> getStats();
}
