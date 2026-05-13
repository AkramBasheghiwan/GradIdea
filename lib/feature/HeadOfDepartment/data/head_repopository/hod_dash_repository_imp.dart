// import 'package:dartz/dartz.dart';
// import 'package:graduation_management_idea_system/core/error/exceptions.dart';
// import 'package:graduation_management_idea_system/core/error/failure.dart';
// import 'package:graduation_management_idea_system/feature/head_of_dep_dashboard/data/data_source/head_remote_data_source.dart';
// import 'package:graduation_management_idea_system/feature/head_of_dep_dashboard/domain/head_repo/head_repository.dart';
// import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
// import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

// class HeadOfDepartmentRepositoryImpl implements HeadRepository {
//   HeadRemoteDataSource remoteDataSource;

//   HeadOfDepartmentRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<ProjectEntity>>> getPendingProjects() async {
//     try {
//       final List<ProjectModel> response = await remoteDataSource
//           .getPendingProjects();

//       return Right(response);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return const Left();
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> approveProject(String projectId) async {
//     try {
//       await remoteDataSource.approveProject(projectId);
//       return const Right(unit);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return Left(
//         NetworkFailure('An unexpected error occurred: ${e.toString()}'),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> rejectProject(
//     String projectId,
//     String reason,
//   ) async {
//     try {
//       await remoteDataSource.rejectProject(projectId, reason);

//       return const Right(unit);
//     } on ServerException catch (e) {
//       return Left(ServerFailure('Supabase error: ${e.message}'));
//     } catch (e) {
//       return Left(
//         NetworkFailure('An unexpected error occurred: ${e.toString()}'),
//       );
//     }
//   }
// }

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/data/model/projects_status_model.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDep_Dashboard/domain/head_repo/hod_dash_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRepositoryImp implements HodDashRepository {
  final SupabaseClient client;

  const DashboardRepositoryImp(this.client);
  @override
  Future<ProjectStatsModel> getStats() async {
    try {
      final res = await client.rpc('get_projects_stats');

      return ProjectStatsModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
