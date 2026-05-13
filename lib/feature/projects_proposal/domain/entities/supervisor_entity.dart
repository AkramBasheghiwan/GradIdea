import 'package:equatable/equatable.dart';

class SupervisorEntity extends Equatable {
  final String id;
  final String name;
  final int currentGroups;
  final int maxGroups;

  const SupervisorEntity({
    required this.id,
    required this.name,
    required this.currentGroups,
    required this.maxGroups,
  });

  int get remain => maxGroups - currentGroups;

  @override
  List<Object?> get props => [id, name, currentGroups, maxGroups];
}
