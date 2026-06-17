import 'package:equatable/equatable.dart';

class SupervisorStatisticsModel extends Equatable {
  final int totalProposals;
  final int pending;
  final int approved;
  final int rejected;

  const SupervisorStatisticsModel({
    required this.totalProposals,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  factory SupervisorStatisticsModel.fromJson(Map<String, dynamic> json) {
    return SupervisorStatisticsModel(
      totalProposals: json['total_proposals'] ?? 0,
      pending: json['pending'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_proposals': totalProposals,
      'pending': pending,
      'approved': approved,
      'rejected': rejected,
    };
  }

  SupervisorStatisticsModel copyWith({
    int? totalProposals,
    int? pending,
    int? approved,
    int? rejected,
  }) {
    return SupervisorStatisticsModel(
      totalProposals: totalProposals ?? this.totalProposals,
      pending: pending ?? this.pending,
      approved: approved ?? this.approved,
      rejected: rejected ?? this.rejected,
    );
  }

  @override
  String toString() {
    return '''
SupervisorStatisticsModel(
  totalProposals: $totalProposals,
  pending: $pending,
  approved: $approved,
  rejected: $rejected,
)
''';
  }

  @override
  List<Object> get props => [totalProposals, pending, approved, rejected];
}
