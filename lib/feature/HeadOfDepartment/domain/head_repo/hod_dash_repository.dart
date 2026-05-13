import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/data/model/projects_status_model.dart';

abstract class HodDashRepository {
  Future<ProjectStatsModel> getStats();
}
