import 'package:equatable/equatable.dart';

class DashboardAnalysisModle extends Equatable {
  final int usersCount;
  final int totalCount;
  final int proposalCount;

  const DashboardAnalysisModle({
    required this.usersCount,
    required this.totalCount,
    required this.proposalCount,
  });

  factory DashboardAnalysisModle.fromMap(Map<String, dynamic> map) {
    return DashboardAnalysisModle(
      usersCount: map['users_count'] ?? 0,
      totalCount: map['totalCount'] ?? 0,
      proposalCount: map['proposalCount'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [usersCount, totalCount, proposalCount];
}
