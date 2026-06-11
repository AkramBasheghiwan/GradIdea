import 'dart:developer';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/app_secrets.dart';
import 'package:graduation_management_idea_system/core/services/file_servicrs/file_upload.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/cache_helper.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UploadProjectRemoteDataSource {
  Future<void> uploadProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project, {File? newFile});
  Future<void> deleteProject(String projectId, String fileUrle);
  Future<List<ProjectModel>> fetchMyProjects({required String status});
  Future<List<ProjectModel>> fetchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  });
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

  UploadProjectRemoteDataSourceImpl({required this.supabase}) {
    final apiKey = AppSecrets.geminiApiKey;
    _embeddingModel = GenerativeModel(
      model: 'gemini-embedding-001',
      apiKey: apiKey,
    );
  }
  final String table = 'projects';

  final userId = CacheHelper.getData(key: AppConstatnce.getUid);
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
  // 1. إضافة مشروع جديد
  // ==========================================
  @override
  Future<void> uploadProject(ProjectModel project) async {
    try {
      log('==============================');
      log('🚀 بدء رفع المشروع');

      String? fileUrl;

      // ===============================
      // 📁 رفع الملف
      // ===============================
      if (project.projectFile != null) {
        log('📤 بدء رفع الملف...');
        fileUrl = await AppFileUpload.uploadFile(
          project.projectFile!,
          supabase,
        );
        log("✅ تم رفع الملف: $fileUrl");
      } else {
        log("⚠️ لا يوجد ملف مرفق");
      }

      // ===============================
      // 🧠 embedding
      // ===============================
      log("🧠 جاري توليد المتجه (Vector)...");
      final vectorArray = await _generateEmbeddingVector(project);
      log("✅ تم توليد المتجه بنجاح");

      // ===============================
      // 📦 تجهيز البيانات
      // ===============================
      final userId = supabase.auth.currentUser?.id;
      log("👤 User ID: $userId");

      final projectData = project.toMap(userId!);

      if (fileUrl != null) {
        projectData['fileurl'] = fileUrl;
      }

      projectData['embedding_vector'] = vectorArray;

      log("📦 البيانات النهائية:");
      log(projectData.toString());

      // ===============================
      // 💾 إدخال البيانات
      // ===============================
      log("💾 إرسال البيانات إلى Supabase...");

      final response = await supabase
          .from('projects')
          .insert(projectData)
          .select();

      log("🟢 Insert Response: $response");

      log("🎉 تم حفظ المشروع بنجاح!");
    }
    // ===============================
    // 🌐 Internet Error
    // ===============================
    on SocketException catch (e) {
      log("🌐 SocketException: $e");
      throw ServerException('لا يوجد اتصال بالإنترنت لرفع المشروع.');
    }
    // ===============================
    // 🔥 Supabase Error (مهم جداً)
    // ===============================
    on PostgrestException catch (e, stackTrace) {
      log('==============================');
      log('❌ PostgrestException');
      log('📌 Message: ${e.message}');
      log('📌 Code: ${e.code}');
      log('📌 Details: ${e.details}');
      log('📌 Hint: ${e.hint}');
      log('📍 StackTrace: $stackTrace');

      _handleDatabaseError(e, "رفع المشروع");

      throw ServerException('خطأ قاعدة البيانات: ${e.message}');
    }
    // ===============================
    // 💥 أي خطأ آخر
    // ===============================
    catch (e, stackTrace) {
      log('==============================');
      log("💥 Unexpected Error: $e");
      log('📍 StackTrace: $stackTrace');

      if (e is ServerException) rethrow;

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

      String? fileUrl;

      // ===============================
      // 📁 معالجة الملف
      // ===============================
      if (newFile != null) {
        String filePath;

        if (project.fileUrl != null) {
          filePath = AppFileUpload.extractPathFromUrl(project.fileUrl!);
          log(' استخدام ملف موجود: $filePath');
        } else {
          filePath =
              'archive_files/${DateTime.now().millisecondsSinceEpoch}_project.pdf';
          log(' ملف جديد لأول مرة: $filePath');
        }

        fileUrl = await AppFileUpload.updateFile(newFile, filePath, supabase);
      }

      // ===============================
      // 🧠 embedding
      // ===============================
      log('🧠 توليد embedding...');
      final vector = await _generateEmbeddingVector(project);

      final data = project.toMap(supabase.auth.currentUser!.id);

      if (fileUrl != null) {
        data['fileurl'] = fileUrl;
      }
      data['reasion_rejection'] = null;
      data['embedding_vector'] = vector;

      log('💾 تحديث قاعدة البيانات...');

      await supabase.from(table).update(data).eq('id', project.id!);

      log('🎉 تم التحديث بنجاح');
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت لحذف المشروع.');
    } on PostgrestException catch (e) {
      log(' Supabase error: ${e.message}');
      _handleDatabaseError(e, 'تحديث المشروع');
    } catch (e) {
      log(' Unexpected error: $e');
      throw ServerException(e.toString());
    }
  }

  // 4. حذف وجلب البيانات (نفس كودك مع تعديل الحقل)
  // ==========================================
  @override
  Future<void> deleteProject(String projectId, String fileUrl) async {
    try {
      log('Project ID type: ${projectId.runtimeType}');
      log('Project ID: $projectId');
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
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت لحذف المشروع.');
    } on PostgrestException catch (e) {
      log(' Supabase error: ${e.message}');
      _handleDatabaseError(e, 'حذف المشروع');
    } catch (e) {
      log(' Unexpected error: $e');
      throw ServerException(
        "${e.toString()}حدث خطاء غير متوقع اثناء حذف المشروع",
      );
    }
  }

  void _handleDatabaseError(PostgrestException e, String operationName) {
    if (e.code == '42501') {
      throw ServerException(
        'عذراً، ليس لديك صلاحية للقيام بـ ($operationName).',
      );
    } else if (e.code == '23505') {
      throw ServerException('هذا المشروع موجود مسبقاً.');
    } else {
      throw ServerException(
        'خطأ في قاعدة البيانات ($operationName): ${e.message}',
      );
    }
  }

  @override
  Future<List<ProjectModel>> fetchMyProjects({required String status}) async {
    try {
      log(supabase.auth.currentUser!.id);
      log(status);
      final response = await supabase
          .from(table)
          .select()
          .eq('status', status)
          .eq('leader_id', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false);

      return (response as List)
          .map((data) => ProjectModel.fromMap(data))
          .toList();
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
      throw ServerException(e.message);
    } catch (e) {
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
      throw ServerException(e.message);
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
          .eq('id', projectId);

      if (response.error != null) {
        throw ServerException(
          'فشل تحديث حالة المشروع: ${response.error!.message}',
        );
      }
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب المشاريع الخاصة بي');
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
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
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب المشاريع: $e');
    }
  }
  // ==========================================
  // 2. فحص التشابه (معدلة لترجع نتائج للـ UI)
  // ==========================================
  // @override
  // Future<List<ProjectModel>> findSimilarProjects(
  //   String projectDescription,
  // ) async {
  //   try {
  //     final result = await _embeddingModel.embedContent(
  //       Content.text(projectDescription),
  //       taskType: TaskType.retrievalQuery,
  //       outputDimensionality: 768,
  //     );
  //     final List<double> queryVector = result.embedding.values;

  //     final List<dynamic> response = await supabase.rpc(
  //       'match_projects',
  //       params: {
  //         'query_embedding': queryVector,
  //         'match_threshold': 0.75,
  //         'match_count': 5,
  //       },
  //     );

  //     return response.map((data) => ProjectModel.fromMap(data)).toList();
  //   } on SocketException {
  //     throw ServerException('لا يوجد اتصال بالإنترنت لإجراء الفحص.');
  //   } on PostgrestException catch (e) {
  //     _handleDatabaseError(e, 'فحص التشابه');
  //     return [];
  //   } catch (e) {
  //     throw ServerException('حدث خطأ أثناء البحث عن أفكار مشابهة: $e');
  //   }
  // }
}
