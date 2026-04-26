import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> fetchAllProjects({
    required String departmentId,
    required String status,
    required int page,
    int limit = 15,
  });

  Future<List<ProjectModel>> searchProjects(String query);
}

class ProjectRemoteDataSourceImp implements ProjectRemoteDataSource {
  final SupabaseClient supabase;

  const ProjectRemoteDataSourceImp(this.supabase);

  @override
  Future<List<ProjectModel>> fetchAllProjects({
    required String departmentId,
    required String status,
    required int page,
    int limit = 15,
  }) async {
    try {
      final int from = page * limit;
      final int to = from + limit - 1;

      final response = await supabase
          .from('projects')
          .select()
          .eq('department', departmentId)
          .eq('status', status)
          .order('created_at', ascending: false)
          .range(from, to);

      return (response as List)
          .map((data) => ProjectModel.fromMap(data))
          .toList();
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب أرشيف المشاريع');
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء الجلب: $e');
    }
  }

  void _handleDatabaseError(PostgrestException e, String operationName) {
    if (e.code == '42501') {
      throw ServerException(
        'عذراً، ليس لديك صلاحية للقيام بـ ($operationName).',
      );
    } else if (e.code == '23505') {
      throw const ServerException('هذا المشروع موجود مسبقاً.');
    } else {
      throw ServerException(
        'خطأ في قاعدة البيانات ($operationName): ${e.message}',
      );
    }
  }

  @override
  Future<List<ProjectModel>> searchProjects(String query) {
    // TODO: implement searchProjects
    throw UnimplementedError();
  }

  // @override
  //  Future<List<ProjectModel>> searchProjects(String query,int page,int limit =15)async {

  //   try{
  //      final int from = page * limit;
  //     final int to = from + limit - 1;
  //      final result = await supabase.from(table).select().eq(column, value).range(from, to)
  //    }
  //  }
}
