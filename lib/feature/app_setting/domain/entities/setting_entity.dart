class AppSettingEntity {
  final int maxGroup;
  final bool canUploadProjects;
  final bool canUploadProposal;

  const AppSettingEntity({
    required this.maxGroup,
    required this.canUploadProjects,
    required this.canUploadProposal,
  });

  AppSettingEntity copyWith({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  }) {
    return AppSettingEntity(
      maxGroup: maxGroup ?? this.maxGroup,
      canUploadProjects: canUploadProjects ?? this.canUploadProjects,
      canUploadProposal: canUploadProposal ?? this.canUploadProposal,
    );
  }
}
