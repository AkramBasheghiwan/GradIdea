// import 'dart:core';

// import 'package:dartz/dartz.dart';
// import 'package:graduation_management_idea_system/core/error/exceptions.dart';
// import 'package:graduation_management_idea_system/core/error/failure.dart';
// import 'package:graduation_management_idea_system/feature/head_of_dep_dashboard/domain/head_repo/head_repository.dart';
// import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

// import '../../../projects/data/model/model.dart';

// abstract class HeadRemoteDataSource {
//   Future<List<ProjectModel>> getPendingProjects();
//   Future<void> approveProject(String projectId);
//   Future<void> rejectProject(String projectId, String reason);
// }

// class HeadOfDepartmentRepositoryImpl implements HeadRemoteDataSource {
//   final SupabaseClient supabaseClient;

//   HeadOfDepartmentRepositoryImpl({required this.supabaseClient});

//   @override
//   Future<List<ProjectModel>> getPendingProjects() async {
//     try {
//       final response = await supabaseClient
//           .from('projects')
//           .select()
//           .eq('status', 'pending');

//       final List<dynamic> projects = (response as List)
//           .map((project) => ProjectModel.fromJson(project))
//           .toList();
//       return projects;
//     } on PostgrestException catch (e) {
//       // خطأ من Supabase (مثل خطأ في RLS)
//       throw (ServerException('Supabase error: ${e.message}'));
//     } catch (e) {
//       // أخطاء أخرى (مثل مشكلة في الشبكة)
//       throw (
//         NetworkException('An unexpected error occurred: ${e.toString()}'),
//       );
//     }
//   }

//   @override
//   Future<void> approveProject(String projectId) async {
//     try {
//       await supabaseClient
//           .from('projects')
//           .update(<String, String>{'status': AppProjectsStatus.approved})
//           .eq('id', projectId);
//     } on PostgrestException catch (e) {
//       throw (ServerException('Supabase error: ${e.message}'));
//     } catch (e) {
//       throw (
//         NetworkException('An unexpected error occurred: ${e.toString()}'),
//       );
//     }
//   }

//   @override
//   Future<void> rejectProject(String projectId, String reason) async {
//     try {
//       await supabaseClient
//           .from('projects')
//           .update(<String, String>{
//             'status': AppProjectsStatus.rejected,
//             'rejection_reason': reason,
//           })
//           .eq('id', projectId);
//     } on PostgrestException catch (e) {
//       throw (ServerException('Supabase error: ${e.message}'));
//     } catch (e) {
//       throw (
//         NetworkException('An unexpected error occurred: ${e.toString()}'),
//       );
//     }
//   }
// }
