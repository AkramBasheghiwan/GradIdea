import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/get_project_repository.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/supabase_upload_project_remote_data_sourcr.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

class GetProjectRepositoryImpl extends GetProjectRepository {
  final UploadProjectRemoteDataSource remoteDataSource;

  GetProjectRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, ProjectEntity>> getProjectDetaile(String id) async {
    try {
      final result = await remoteDataSource.getprojectDetatil(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
