import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProposalApprovedRemoteDataSource {
  Future<List<ProjectProposalsModel>> fetchAllProposals({
    required String departmentId,
    required String status,
    required int page,
    int limit = 15,
  });

  Future<List<ProjectProposalsModel>> searchProposal({
    required String query,
    String? department,
    String? year,
    required int page,
  });
}

class ProposalApprovedRemoteDataSourceImpl
    implements ProposalApprovedRemoteDataSource {
  final SupabaseClient supabase;

  ProposalApprovedRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<ProjectProposalsModel>> fetchAllProposals({
    required String departmentId,
    required String status,
    required int page,
    int limit = 15,
  }) async {
    try {
      final int from = page * limit;
      final int to = from + limit - 1;

      final response = await supabase
          .from('')
          .select()
          .eq('department', departmentId)
          .eq('status', status)
          .order('created_at', ascending: false)
          .range(from, to);

      return (response as List)
          .map((data) => ProjectProposalsModel.fromMap(data))
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
  Future<List<ProjectProposalsModel>> searchProposal({
    required String query,
    String? department,
    String? year,
    required int page,
  }) async {
    try {
      const limit = 15;
      final from = page * limit;
      final to = from + limit - 1;

      var queryBuilder = supabase.from('').select();
      if (query.isNotEmpty) {
        queryBuilder = queryBuilder.or(
          'name.ilike.%$query%,description.ilike.%$query%,supervisor.ilike.%$query%',
        );
      }
      if (department != null && department.isNotEmpty) {
        queryBuilder = queryBuilder.eq('department', department);
      }

      if (year != null && year.isNotEmpty) {
        queryBuilder = queryBuilder.eq('year', year);
      }
      final response = await queryBuilder
          .order('created_at', ascending: false) // ترتيب من الأحدث للأقدم
          .range(from, to);

      return (response as List<dynamic>)
          .map((e) => ProjectProposalsModel.fromMap(e))
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
}
