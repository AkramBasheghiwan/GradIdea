import 'dart:developer';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/services/file_servicrs/file_upload.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> findSimilarProjects(String projectDescription);
  Future<void> uploadProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String projectId);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final SupabaseClient supabase;
  late final GenerativeModel _embeddingModel;

  ProjectRemoteDataSourceImpl({required this.supabase}) {
    const apiKey = 'AIzaSyAmqZtjZHYAV4Z3HNVwHn60yVNFbkiPBgk';
    _embeddingModel = GenerativeModel(
      model: 'gemini-embedding-001',
      apiKey: apiKey,
    );
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
      // 🚨 الطباعة هنا لاكتشاف الخطأ
      log("❌ خطأ Gemini: ${e.message}");
      throw ServerException('فشل الذكاء الاصطناعي: ${e.message}');
    } catch (e) {
      log("❌ خطأ غير متوقع في Gemini: $e");
      throw ServerException('حدث خطأ أثناء معالجة نصوص المشروع: $e');
    }
  }

  // ==========================================
  // 1. إضافة مشروع جديد
  // ==========================================
  @override
  @override
  Future<void> uploadProject(ProjectModel project) async {
    try {
      String? fileUrl;

      log("⏳ بدأ الرفع: التحقق من وجود ملف...");
      if (project.projectFile != null) {
        log("⏳ جاري رفع الملف لـ Supabase Storage...");
        // 🚨 إذا كانت المشكلة هنا، ستتوقف الطباعة
        fileUrl = await AppFileUpload.uploadFile(
          project.projectFile!,
          supabase,
        );
        log("✅ تم رفع الملف: $fileUrl");
      }

      log("⏳ جاري توليد المتجه (Vector)...");
      final vectorArray = await _generateEmbeddingVector(project);
      log("✅ تم توليد المتجه بنجاح");

      final projectData = project.toMap();
      if (fileUrl != null) {
        projectData['fileurl'] = fileUrl; // تأكد من مطابقة الاسم
      }
      projectData['embedding_vector'] = vectorArray;

      log("⏳ جاري إرسال البيانات: $projectData");
      await supabase.from('projects').insert(projectData);
      log("✅ تم حفظ المشروع بنجاح!");
    } on PostgrestException catch (e) {
      // 🚨 طباعة تفاصيل خطأ قاعدة البيانات
      log(
        "❌ خطأ Database (Postgrest): كود=${e.code}, رسالة=${e.message}, تفاصيل=${e.details}",
      );
      throw ServerException('خطأ قاعدة البيانات: ${e.message}');
    } catch (e) {
      // 🚨 طباعة أي خطأ آخر (مثل StorageException لو جاء من AppFileUpload)
      log("❌ خطأ عام أثناء الرفع: $e");
      if (e is ServerException)
        rethrow; // يرمي الـ ServerException القادم من الدوال المساعدة
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  // ==========================================
  // 2. فحص التشابه (معدلة لترجع نتائج للـ UI)
  // ==========================================
  @override
  Future<List<ProjectModel>> findSimilarProjects(
    String projectDescription,
  ) async {
    try {
      final result = await _embeddingModel.embedContent(
        Content.text(projectDescription),
        taskType: TaskType.retrievalQuery,
        outputDimensionality: 768,
      );
      final List<double> queryVector = result.embedding.values;

      final List<dynamic> response = await supabase.rpc(
        'match_projects',
        params: {
          'query_embedding': queryVector,
          'match_threshold': 0.75,
          'match_count': 5,
        },
      );

      return response.map((data) => ProjectModel.fromMap(data)).toList();
    } on SocketException {
      throw ServerException('لا يوجد اتصال بالإنترنت لإجراء الفحص.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'فحص التشابه');
      return [];
    } catch (e) {
      throw ServerException('حدث خطأ أثناء البحث عن أفكار مشابهة: $e');
    }
  }

  // ==========================================
  // 3. تحديث مشروع موجود
  // ==========================================
  @override
  Future<void> updateProject(ProjectModel project) async {
    try {
      if (project.id == null) {
        throw ServerException('لا يمكن تحديث مشروع بدون معرف (ID)');
      }

      final vectorArray = await _generateEmbeddingVector(project);
      final projectData = project.toMap();
      projectData['embedding_vector'] = vectorArray;

      await supabase.from('projects').update(projectData).eq('id', project.id!);
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'تحديث المشروع');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  // ==========================================
  // 4. حذف وجلب البيانات (نفس كودك مع تعديل الحقل)
  // ==========================================
  @override
  Future<void> deleteProject(String projectId) async {
    try {
      await supabase.from('projects').delete().eq('id', projectId);
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'حذف المشروع');
    } catch (e) {
      throw ServerException(e.toString());
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
}
