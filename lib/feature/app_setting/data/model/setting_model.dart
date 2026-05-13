import 'package:graduation_management_idea_system/feature/app_setting/domain/entities/setting_entity.dart';

class AppSettingModel extends AppSettingEntity {
  const AppSettingModel({
    required super.maxGroup,
    required super.canUploadProjects,
    required super.canUploadProposal,
  });

  factory AppSettingModel.fromJson(Map<String, dynamic> json) {
    return AppSettingModel(
      maxGroup: json['max_group'] ?? 0,
      canUploadProjects: json['can_upload_projects'] ?? true,
      canUploadProposal: json['can_upload_proposal'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_group': maxGroup,
      'can_upload_projects': canUploadProjects,
      'can_upload_proposal': canUploadProposal,
    };
  }
}
