class SimilarProjectEntity {
  final String id;
  final String title;
  final String description;
  final String department;
  final int year;
  final double similarityPercentage;

  SimilarProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.year,
    required this.similarityPercentage,
  });
}
