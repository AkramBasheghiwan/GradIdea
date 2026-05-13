class ProjectStatsModel {
  final int pending;
  final int approved;
  final int rejected;
  final int total;

  ProjectStatsModel({
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.total,
  });

  factory ProjectStatsModel.fromJson(Map<String, dynamic> json) {
    return ProjectStatsModel(
      pending: json['pending'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
