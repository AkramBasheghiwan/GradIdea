import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectProposalRemoteDataSource {
  Future<List<ProjectProposalsModel>> getProposalToSupervisor(String status);
  Future<List<ProjectProposalsModel>> getMyProposals(String status);
  Future<List<ProjectProposalsModel>> getProposalsToHOD(String departmentId);

  Future<void> uploadProjectProposal(ProjectProposalsModel proposalData);
  Future<void> updateProposal(ProjectProposalsModel proposalData);
  Future<void> deleteProjectProposal(String id);

  Future<void> updateProposalStatus({
    required String id,
    required String status,
    String? rejectionReason,
  });
}

class ProjectProposalRemoteDataSourceImpl
    implements ProjectProposalRemoteDataSource {
  final SupabaseClient _supabase;

  ProjectProposalRemoteDataSourceImpl(this._supabase);

  static const String table = 'project_groups';

  @override
  Future<List<ProjectProposalsModel>> getProposalToSupervisor(
    String status,
  ) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw const ServerException("لا توجد جلسة تسجيل دخول.");
      }

      final response = await _supabase
          .from(table)
          .select()
          .eq('supervisor_id', userId)
          .eq('status', status);

      return (response as List)
          .map((e) => ProjectProposalsModel.fromMap(e))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (_) {
      throw const ServerException("حدث خطأ أثناء جلب المشاريع.");
    }
  }

  @override
  Future<List<ProjectProposalsModel>> getMyProposals(String status) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw const ServerException("لا توجد جلسة تسجيل دخول.");
      }

      final response = await _supabase
          .from(table)
          .select()
          .eq('leader_id', userId)
          .eq('status', status);

      return (response as List)
          .map((e) => ProjectProposalsModel.fromMap(e))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (_) {
      throw const ServerException("حدث خطأ أثناء جلب المشاريع.");
    }
  }

  @override
  Future<List<ProjectProposalsModel>> getProposalsToHOD(
    String department,
  ) async {
    try {
      final response = await _supabase
          .from(table)
          .select()
          .eq('department', department)
          .eq('status', AppProjectsStatus.approved);

      return (response as List)
          .map((e) => ProjectProposalsModel.fromMap(e))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (_) {
      throw const ServerException("حدث خطأ أثناء جلب المشاريع.");
    }
  }

  @override
  Future<void> uploadProjectProposal(ProjectProposalsModel proposalData) async {
    try {
      await _supabase.from(table).insert(proposalData.toMap());
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> updateProposal(ProjectProposalsModel proposalData) async {
    try {
      await _supabase
          .from(table)
          .update(proposalData.toMap())
          .eq('id', proposalData.id.toString());
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> deleteProjectProposal(String id) async {
    try {
      await _supabase.from(table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> updateProposalStatus({
    required String id,
    required String status,
    String? rejectionReason,
  }) async {
    try {
      final data = {'status': status, 'rejection_reason': rejectionReason};

      await _supabase.from(table).update(data).eq('id', id.toString());
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }
}
