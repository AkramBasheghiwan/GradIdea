import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class GetProjectState extends Equatable {
  const GetProjectState();
  @override
  List<Object> get props => [];
}

class GetProjectInitail extends GetProjectState {}

class GetProjectLoaded extends GetProjectState {
  final ProjectEntity project;

  const GetProjectLoaded({required this.project});

  @override
  List<Object> get props => [project];
}

class GetProjectLoading extends GetProjectState {}

class GetProjectError extends GetProjectState {
  final String message;
  const GetProjectError({required this.message});
  @override
  List<Object> get props => [message];
}
