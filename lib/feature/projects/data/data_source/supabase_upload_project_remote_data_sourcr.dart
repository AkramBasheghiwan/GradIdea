import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/app_secrets.dart';
import 'package:graduation_management_idea_system/core/services/api_service/api_service.dart';
import 'package:graduation_management_idea_system/core/services/file_servicrs/file_upload.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/add_paper.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UploadProjectRemoteDataSource {
  Future<void> uploadProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project, {File? newFile});
  Future<void> deleteProject(String projectId, String fileUrle);
  Future<List<ProjectModel>> fetchMyProjects({required String status});
  Stream<List<ProjectModel>> watchMyProjects({required String status});
  Stream<List<ProjectModel>> watchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  });
  Future<List<ProjectModel>> fetchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  });
  Future<ProjectModel> getprojectDetatil(String projectid);
  Future<void> updateProjectsStatus(String projectId, String newStatus);
  Future<void> updateProjectsStatusReject({
    required String projectid,
    required String status,
    String? reason,
  });
}

class UploadProjectRemoteDataSourceImpl
    implements UploadProjectRemoteDataSource {
  final SupabaseClient supabase;
  late final GenerativeModel _embeddingModel;
  late final GenerativeModel _generativeModle;
  late ApiService apiService;

  UploadProjectRemoteDataSourceImpl({required this.supabase}) {
    final apiKey = AppSecrets.geminiApiKey;
    apiService = ApiService();
    _embeddingModel = GenerativeModel(
      model: 'gemini-embedding-001',
      apiKey: apiKey,
    );
    _generativeModle = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
  }
  final String table = 'projects';

  @override
  Future<void> uploadProject(ProjectModel project) async {
    String? fileUrl;
    try {
      if (project.projectFile != null) {
        fileUrl = await AppFileUpload.uploadFile(
          project.projectFile!,
          supabase,
        );
        log(" تم رفع الملف: $fileUrl");
      } else {
        log(" لا يوجد ملف مرفق");
      }
      //empending
      log(" جاري توليد المتجه (Vector)...");
      final vectorArray = await _generateEmbeddingVector(project);
      log(" تم توليد المتجه بنجاح");
      final userId = supabase.auth.currentUser?.id;
      log(" User ID: $userId");
      final projectData = project.toMap(userId!);

      if (fileUrl != null) {
        projectData['fileurl'] = fileUrl;
      }

      projectData['embedding_vector'] = vectorArray;

      log(" البيانات النهائية:");
      log(projectData.toString());

      final response = await supabase
          .from('projects')
          .insert(projectData)
          .select()
          .single();

      final resulte = ProjectModel.fromMap(response);
      final role = CacheHelper.getData(key: AppConstatnce.getRole);
      try {
        if (role == AppRoles.admin || role == AppRoles.headOfDepartment) {
          await apiService.addPaper(
            PaperCreate(
              keywords: await _keywordFromGemini(
                title: resulte.name,
                abstract: resulte.description,
              ),
              externalId: resulte.id!,
              title: resulte.name,
              abstract: resulte.description,
            ),
          );

          log('تم رفع الملف الي api');
        }
      } catch (e) {
        throw ServerException("فشل الرفع في ال api");
      }

      log("🎉 تم حفظ المشروع بنجاح!");
    } on SocketException catch (e) {
      log("🌐 SocketException: $e");
      throw ServerException('لا يوجد اتصال بالإنترنت لرفع المشروع.');
    } on PostgrestException catch (e, stackTrace) {
      log('==============================');
      log('❌ PostgrestException');
      log('📌 Message: ${e.message}');
      log('📌 Code: ${e.code}');
      log('📌 Details: ${e.details}');
      log('📌 Hint: ${e.hint}');
      log('📍 StackTrace: $stackTrace');
      if (fileUrl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileUrl);
        await supabase.storage.from('archive_files').remove([path]);
      }
      _handleDatabaseError(e, "رفع المشروع");
    } catch (e, stackTrace) {
      log('==============================');
      log("💥 Unexpected Error: $e");
      log('📍 StackTrace: $stackTrace');

      if (e is ServerException) rethrow;
      if (fileUrl != null) {
        final path = AppFileUpload.extractPathFromUrl(fileUrl);
        await supabase.storage.from('archive_files').remove([path]);
      }
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  // ==========================================
  // 3. تحديث مشروع موجود
  // ==========================================
  @override
  Future<void> updateProject(ProjectModel project, {File? newFile}) async {
    try {
      if (project.id == null) {
        throw ServerException('ID مفقود');
      }
      String? fileUrl = project.fileUrl;

      if (newFile != null) {
        String? filePath;

        if (project.fileUrl != null && project.fileUrl!.isNotEmpty) {
          filePath = AppFileUpload.extractPathFromUrl(project.fileUrl!);
          log(' استخدام ملف موجود: $filePath');
          fileUrl = await AppFileUpload.updateFile(newFile, filePath, supabase);
        } else {
          log('لا يوجد ملف قديم، سيتم رفع ملف جديد');
          fileUrl = await AppFileUpload.uploadFile(newFile, supabase);
        }
      }

      final vector = await _generateEmbeddingVector(project);

      final data = project.toMap(supabase.auth.currentUser!.id);

      if (fileUrl != null) {
        data['fileurl'] = fileUrl;
      }
      data['rejection_reason'] = null;
      data['embedding_vector'] = vector;
      log(' تحديث قاعدة البيانات...');
      final response = await supabase
          .from(table)
          .update(data)
          .eq('id', project.id!)
          .select()
          .single();
      final resulte = ProjectModel.fromMap(response);

      final role = CacheHelper.getData(key: AppConstatnce.getRole);
      if (role == AppRoles.admin || role == AppRoles.headOfDepartment) {
        try {
          final keywords = await _keywordFromGemini(
            title: resulte.name,
            abstract: resulte.description,
          );
          log('تم استخراج الكلمات المفتاحية');
          log('بدء رفع الورقة إلى API...');
          final paper = UpdatePaperRequest(
            title: resulte.name,
            abstract: resulte.description,
            keywords: keywords,
          );

          await apiService.updatePaper(resulte.id!, paper);

          log(' تم رفع الورقة إلى API بنجاح');
        } catch (e, stackTrace) {
          log('StackTrace: $stackTrace');
          throw ServerException('فشل الرفع في api');
        }
      }

      log('🎉 تم التحديث بنجاح');
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت لحذف المشروع.');
    } on PostgrestException catch (e, stackTrace) {
      log('==============================');
      log('❌ PostgrestException');
      log('📌 Message: ${e.message}');
      log('📌 Code: ${e.code}');
      log('📌 Details: ${e.details}');
      log('📌 Hint: ${e.hint}');
      log('📍 StackTrace: $stackTrace');
      _handleDatabaseError(e, 'تحديث المشروع');
    } catch (e, stackTrace) {
      log('==============================');
      log('❌ PostgrestException');
      log('📍 StackTrace: $stackTrace');
      log(' Unexpected error: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteProject(String projectId, String fileUrl) async {
    try {
      final response = await supabase
          .from(table)
          .delete()
          .eq('id', projectId)
          .select();

      if (response.isEmpty) {
        throw ServerException(
          'قد تم حذف المشروع مسبقاً أو لم يتم العثور عليه.',
        );
      }

      log(' Project deleted successfully: $projectId');
      final path = AppFileUpload.extractPathFromUrl(fileUrl);
      await supabase.storage.from('archive_files').remove([path]);
      log('✅ تم حذف الملف');
      try {
        await apiService.deletePaper(projectId);
      } catch (e) {
        throw ServerException('لم يتم حذف المشروع  ');
      }
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت لحذف المشروع.');
    } on PostgrestException catch (e, stackTrace) {
      log('==============================');
      log('❌ PostgrestException');
      log('📌 Message: ${e.message}');
      log('📌 Code: ${e.code}');
      log('📌 Details: ${e.details}');
      log('📌 Hint: ${e.hint}');
      log('📍 StackTrace: $stackTrace');
      _handleDatabaseError(e, 'حذف المشروع');
    } catch (e) {
      log(' Unexpected error: $e');
      throw ServerException(
        "${e.toString()}حدث خطاء غير متوقع اثناء حذف المشروع",
      );
    }
  }

  @override
  Future<ProjectModel> getprojectDetatil(String projectid) async {
    try {
      final respose = await supabase
          .from(table)
          .select()
          .eq('id', projectid)
          .single();

      return ProjectModel.fromMap(respose);
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }

  Never _handleDatabaseError(PostgrestException e, String operation) {
    switch (e.code) {
      case '23505':
        throw ServerException('البيانات موجودة مسبقاً.');

      case '42501':
        throw ServerException('ليس لديك صلاحية لتنفيذ هذه العملية.');

      case 'PGRST116':
        throw ServerException('البيانات المطلوبة غير موجودة.');

      default:
        throw ServerException('حدث خطأ أثناء $operation.');
    }
  }

  //===========================================================
  @override
  Stream<List<ProjectModel>> watchMyProjects({required String status}) {
    try {
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw ServerException('غير مصرح');
      }

      final query = supabase
          .from(table)
          .stream(primaryKey: ['id'])
          .eq('leader_id', userId);

      return query.map((data) {
        return data
            .where((e) => e['status'] == status)
            .map((e) => ProjectModel.fromMap(e))
            .toList();
      });
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }

  @override
  Future<List<ProjectModel>> fetchMyProjects({required String status}) async {
    try {
      log(status);
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw ServerException('المستخدم غير مصرح له.');
      }

      log(userId);
      final response = await supabase
          .from(table)
          .select()
          .eq('status', status)
          .eq('leader_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((data) => ProjectModel.fromMap(data))
          .toList();
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }

  @override
  Stream<List<ProjectModel>> watchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  }) {
    try {
      final response = supabase.from(table).stream(primaryKey: ['id']);

      return response.map((data) {
        if (data.isEmpty) {
          debugPrint('⚠️ STREAM DATA IS EMPTY');
        }

        final filtered = data.where((e) {
          final dept = e['department']?.toString();
          final st = e['status']?.toString();

          final match = dept == departmentId && st == status;

          debugPrint('➡️ row: dept=$dept | status=$st | match=$match');

          return match;
        }).toList();

        debugPrint('✅ FILTERED RESULT COUNT: ${filtered.length}');
        debugPrint('==============================');

        return filtered.map((e) => ProjectModel.fromMap(e)).toList();
      });
    } catch (e, stack) {
      debugPrint('❌ STREAM ERROR OCCURRED');
      debugPrint('📌 ERROR: $e');
      debugPrint('📌 STACK: $stack');

      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }

  @override
  Future<List<ProjectModel>> fetchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  }) async {
    try {
      final response = await supabase
          .from(table)
          .select()
          .eq('department', departmentId)
          .eq('status', status)
          .order('created_at', ascending: false);

      return (response as List)
          .map((data) => ProjectModel.fromMap(data))
          .toList();
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }

  @override
  Future<void> updateProjectsStatus(String projectId, String newStatus) async {
    try {
      final response = await supabase
          .from(table)
          .update({'status': newStatus})
          .eq('id', projectId)
          .select()
          .single();

      final result = ProjectModel.fromMap(response);
      log('انتهت العملية بنجاح');
      log('============================');
      try {
        final keywords = await _keywordFromGemini(
          title: result.name,
          abstract: result.description,
        );

        log('تم استخراج الكلمات المفتاحية');
        log('Keywords: $keywords');
        log('بدء رفع الورقة إلى API...');

        final paper = PaperCreate(
          externalId: result.id!,
          title: result.name,
          abstract: result.description,
          keywords: keywords,
        );

        await apiService.addPaper(paper);

        log(' تم رفع الورقة إلى API بنجاح');
      } catch (e, stackTrace) {
        log('StackTrace: $stackTrace');
        throw ServerException('فشل الرفع في api');
      }

      log('انتهت العملية بنجاح');
      log('============================');
    } on SocketException {
      log(' لا يوجد اتصال بالإنترنت');
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      log(' خطأ في Supabase');
      log('Message: ${e.message}');
      log('Code: ${e.code}');

      _handleDatabaseError(e, 'تحديث حالة المشروع');
    } catch (e, stackTrace) {
      log('❌ خطأ غير متوقع');
      log('Error: $e');
      log('StackTrace: $stackTrace');

      throw ServerException('حدث خطأ غير متوقع أثناء تحديث المشروع: $e');
    }
  }

  @override
  Future<void> updateProjectsStatusReject({
    required String projectid,
    required String status,
    String? reason,
  }) async {
    try {
      final response = await supabase
          .from(table)
          .update({'status': status, 'rejection_reason': reason})
          .eq('id', projectid);

      if (response.error != null) {
        throw ServerException(
          'فشل تحديث حالة المشروع: ${response.error!.message}',
        );
      }
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
    } catch (e) {
      throw ServerException(
        'حدث خطأ غير متوقع أثناء جلب المشاريع: ${e.toString()}',
      );
    }
  }

  // ==========================================
  // 0. دالة مساعدة لتوليد الـ Vector
  // ==========================================
  Future<List<double>> _generateEmbeddingVector(ProjectModel project) async {
    try {
      final textForEmbedding =
          "عنوان المشروع: ${project.name}\nوصف المشروع: ${project.description}";
      final content = Content.text(textForEmbedding);
      final embeddingResult = await _embeddingModel.embedContent(
        content,
        taskType: TaskType.retrievalDocument,
        outputDimensionality: 768,
      );
      return embeddingResult.embedding.values;
    } on GenerativeAIException catch (e) {
      log(" خطأ Gemini: ${e.message}");
      throw ServerException('فشل الذكاء الاصطناعي: ${e.message}');
    } catch (e) {
      log(" خطأ غير متوقع في Gemini: $e");
      throw ServerException('حدث خطأ أثناء معالجة نصوص المشروع: $e');
    }
  }

  // ==========================================
  // داله مساعده لانشاء ال keywords
  // ==========================================
  Future<String> _keywordFromGemini({
    required String title,
    required String abstract,
  }) async {
    try {
      final model = _generativeModle;

      final prompt =
          '''
Extract 5 to 10 academic keywords from the following graduation project idea.

Requirements:
- Return ONLY the keywords.
- Separate keywords using commas.
- Do not include numbering or explanations.
- Use arabic or english keywords .

Title:
$title

Abstract:
$abstract
''';

      final response = await model.generateContent([Content.text(prompt)]);

      final keywords = response.text?.trim();

      if (keywords == null || keywords.isEmpty) {
        throw ServerException('Failed to generate keywords');
      }
      log(keywords);
      return keywords;
    } on SocketException {
      throw ServerException('لايوجد اتصال بالانترنت ');
    } catch (e) {
      throw ServerException('Error generating keywords: $e');
    }
  }
}
