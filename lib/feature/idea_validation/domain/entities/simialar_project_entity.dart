class SimilarProjectEntity {
  final String id;
  final String title;
  final String description;
  final String department;
  final String year;
  final double similarityPercentage;
  final String matchType;
  SimilarProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.year,
    required this.similarityPercentage,
    required this.matchType,
  });
}

String getMatchType(double score) {
  if (score >= 0.9) return 'duplicate';
  if (score >= 0.8) return 'very_similar';
  if (score >= 0.7) return 'similar';
  return 'unique';
}
