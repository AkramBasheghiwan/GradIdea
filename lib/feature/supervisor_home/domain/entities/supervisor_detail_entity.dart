import 'package:equatable/equatable.dart';

class SupervisorDetailsEntity extends Equatable {
  final String id; // هو نفسه id المستخدم
  final int maxGroupsCount;
  final int currentGroupsCount;

  const SupervisorDetailsEntity({
    required this.id,
    required this.maxGroupsCount,
    required this.currentGroupsCount,
  });

  @override
  List<Object?> get props => [id, maxGroupsCount, currentGroupsCount];
}
