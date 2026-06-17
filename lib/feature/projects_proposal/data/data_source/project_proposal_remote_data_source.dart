import 'dart:developer';
import 'dart:io';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/services/file_servicrs/file_upload.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectProposalRemoteDataSource {
  Future<List<ProjectProposalsModel>> getProposalToSupervisor(String status);
  Future<List<ProjectProposalsModel>> getMyProposals(String status);
  Future<List<ProjectProposalsModel>> getProposalsToHOD(String departmentId);

  Future<void> uploadProjectProposal(ProjectProposalsModel proposalData);
  Future<void> updateProposal(
    ProjectProposalsModel proposalData,
    File? newFile,
  );
  Future<void> deleteProjectProposal(String id, String fileUrl);
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
    } on SocketException catch (e) {
      log("🌐 SocketException: $e");
      throw const ServerException('لايوجد اتصال ب الانترنت ');
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

      log('======================');
      log('🚀 getMyProposals');
      log('👤 User ID: $userId');
      log('📌 Status: $status');

      final response = await _supabase
          .from(table)
          .select()
          .eq('leader_id', userId)
          .eq('status', status);

      log('✅ Query Success');
      log('📦 Rows Count: ${response.length}');
      log('📄 Raw Response: $response');

      final proposals = (response as List).map((e) {
        log('----------------------');
        log('📄 Current Row: $e');

        final proposal = ProjectProposalsModel.fromMap(e);

        log(
          '✅ Proposal Parsed Successfully: '
          '${proposal.id}',
        );

        return proposal;
      }).toList();

      log('🎯 Final Proposals Count: ${proposals.length}');

      return proposals;
    } on SocketException catch (e) {
      log("🌐 SocketException: $e");
      throw const ServerException('لايوجد اتصال ب الانترنت ');
    } on PostgrestException catch (e, stackTrace) {
      log('❌ PostgrestException');
      log('Message: ${e.message}');
      log('Code: ${e.code}');
      log('Details: ${e.details}');
      log('Hint: ${e.hint}');
      log(stackTrace.toString());

      throw ServerException(e.message);
    } catch (e, stackTrace) {
      log('❌ Unknown Error');
      log(e.toString());
      log(stackTrace.toString());

      throw ServerException('حدث خطأ أثناء جلب المشاريع: $e');
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
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (_) {
      throw const ServerException("حدث خطأ أثناء جلب المشاريع.");
    }
  }

  @override
  Future<void> uploadProjectProposal(ProjectProposalsModel proposalData) async {
    String? fileurl;
    try {
      if (proposalData.projectFile != null) {
        fileurl = await AppFileUpload.uploadFile(
          proposalData.projectFile!,
          _supabase,
        );
      }

      final user = _supabase.auth.currentUser!.id;
      if (user.isEmpty) {
        throw const ServerException(
          'لايمكن اكمال هذه العمليه لعدم وجود رقم الفريد الخاص بك اعد تسجيل الدخول مره اخرى',
        );
      }

      var data = proposalData.toMap(user);
      data['fileurl'] = fileurl;
      await _supabase.from(table).insert(data);
    } on SocketException {
      throw const ServerException('لايوجد اتصال انترنت اعد المحاوله لاحقا');
    } on PostgrestException catch (e) {
      if (fileurl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileurl);
        await _supabase.storage.from('archive_files').remove([path]);
      }
      _handleDatabaseError(e, 'رفع مقترح');
    } catch (e) {
      if (fileurl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileurl);
        await _supabase.storage.from('archive_files').remove([path]);
      }
      throw ServerException('حدث خطا غير متوقع ${e.toString()}');
    }
  }

  @override
  Future<void> updateProposal(
    ProjectProposalsModel proposalData,
    File? newFile,
  ) async {
    String? fileUrl;
    try {
      if (proposalData.id == null) {
        throw ServerException(
          "لايوجد رقم فريد لحذف هذا المقترح ${proposalData.id}",
        );
      }
      if (newFile != null) {
        String filePath;

        if (proposalData.fileUrl != null) {
          filePath = AppFileUpload.extractPathFromUrl(proposalData.fileUrl!);
          log(' استخدام ملف موجود: $filePath');
          fileUrl = await AppFileUpload.updateFile(
            newFile,
            filePath,
            _supabase,
          );
        }
      }
      final data = proposalData.toMap(_supabase.auth.currentUser!.id);

      if (fileUrl != null) {
        data['fileurl'] = fileUrl;
      }
      data['rejection_reason'] = null;
      data['status'] = AppProjectsStatus.pending;
      await _supabase
          .from(table)
          .update(data)
          .eq('id', proposalData.id.toString());
    } on SocketException catch (e) {
      throw ServerException('لا يوجد اتصال بالإنترنت: ${e.message}');
    } on PostgrestException catch (e) {
      if (fileUrl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileUrl);
        await _supabase.storage.from('archive_files').remove([path]);
      }
      _handleDatabaseError(e, 'تحديث حاله المشروع');
      throw ServerException(e.message);
    } catch (e) {
      if (fileUrl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileUrl);
        await _supabase.storage.from('archive_files').remove([path]);
      }
      throw ServerException('حدث خطا غير متوقع ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProjectProposal(String id, String fileUrl) async {
    try {
      if (id.isEmpty) {
        throw const ServerException("لايوجد رقم فريد لحذف هذا المقترح");
      }

      log(' Deleting proposal with ID: $id');
      final response = await _supabase
          .from(table)
          .delete()
          .eq('id', id)
          .select();

      if (response.isEmpty) {
        throw const ServerException('لم يتم العثور على المشروع للحذف');
      }

      log(' Project deleted successfully: $id');

      final path = AppFileUpload.extractPathFromUrl(fileUrl);

      await _supabase.storage.from('archive_files').remove([path]);
    } on SocketException {
      throw const ServerException('لايوجد اتصال انترنت ');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'حذف مشروع');
    } catch (e) {
      throw ServerException('حدث خطا غير متوقع اثنا حذف المشرع${e.toString()}');
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
    } on SocketException {
      throw const ServerException('لايوجد اتصال انترنت ');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'تعديل حاله المشروع');
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        'حدث خطا غير متوقع اثنا تعديل حاله المشروع${e.toString()}',
      );
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
}
