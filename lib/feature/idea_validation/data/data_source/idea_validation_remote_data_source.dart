import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/validation_result_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IdeaValidationRemoteDataSource {
  Future<ValidationResultEntity> validateIdea(String ideaText);
  Future<String> getAiEnhancements(
    String studentIdea,
    List<String> oldProjects,
  );
}

class IdeaValidationRemoteDataSourceImpl
    implements IdeaValidationRemoteDataSource {
  final SupabaseClient supabase;

  final String _apiKey = 'AIzaSyAmqZtjZHYAV4Z3HNVwHn60yVNFbkiPBgk';

  late final GenerativeModel _embeddingModel;
  late final GenerativeModel _generativeModel;

  IdeaValidationRemoteDataSourceImpl({required this.supabase}) {
    _embeddingModel = GenerativeModel(
      model: 'gemini-embedding-001',
      apiKey: _apiKey,
    );
    _generativeModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<List<double>> _generateEmbeddingVector(String ideaText) async {
    try {
      final content = Content.text(ideaText);
      final embeddingResult = await _embeddingModel.embedContent(
        content,
        taskType: TaskType.retrievalDocument,
        outputDimensionality: 768,
      );

      log('✅ تم توليد المتجه بنجاح');
      return embeddingResult.embedding.values;
    } on GenerativeAIException catch (e) {
      throw ServerException(
        'فشل الذكاء الاصطناعي في تحليل المشروع: ${e.message}',
      );
    } catch (e) {
      throw ServerException('حدث خطأ أثناء معالجة نصوص المشروع: $e');
    }
  }

  @override
  Future<ValidationResultEntity> validateIdea(String ideaText) async {
    try {
      // 1. توليد المتجه الخاص بالفكرة المدخلة
      final List<double> queryVector = await _generateEmbeddingVector(ideaText);

      final List<dynamic> similarProjects = await supabase.rpc(
        'match_projects',
        params: {
          'query_embedding': queryVector,
          'match_threshold': 0.75,
          'match_count': 5,
        },
      );

      List<SimilarProjectEntity> similarProjectsList = [];

      for (var item in similarProjects) {
        final data = item as Map<String, dynamic>;

        final distance = (data['distance'] as num?)?.toDouble() ?? 1.0;

        double similarityPercentage = (1 - distance) * 100;

        if (similarityPercentage >= 80) {
          similarProjectsList.add(
            SimilarProjectEntity(
              id: data['id']?.toString() ?? '',
              title: data['name'] ?? 'بدون عنوان',
              description: data['description'] ?? '',
              similarityPercentage: similarityPercentage,
              department: data['department'] ?? '',
              year: data['year'],
            ),
          );
        }
      }

      if (similarProjectsList.isEmpty) {
        return ValidationResultEntity(isUnique: true);
      } else {
        return ValidationResultEntity(
          isUnique: false,
          similarProjects: similarProjectsList,
        );
      }
    } on PostgrestException catch (e) {
      throw ServerException(
        'فشل الاتصال بقاعدة البيانات أثناء البحث: ${e.message}',
      );
    } on GenerativeAIException catch (e) {
      throw ServerException(
        'فشل الذكاء الاصطناعي في تحليل الفكرة: ${e.message}',
      );
    } catch (e) {
      log('Error: $e'); // للديناج وتتبع الأخطاء
      throw ServerException('حدث خطأ غير متوقع أثناء عملية الفحص: $e');
    }
  }

  @override
  Future<String> getAiEnhancements(
    String studentIdea,
    List<String> oldProjects,
  ) async {
    String context = oldProjects.join('\n- ');
    final prompt =
        '''
      أنت مستشار أكاديمي في كلية تكنولوجيا المعلومات.
      طالب يقترح فكرة مشروع التخرج التالية:
      "$studentIdea"

      وجدنا مشاريع سابقة مشابهة جداً في قاعدة البيانات:
      - $context

      بناءً على هذه المشاريع، اقترح 3 إضافات تقنية متقدمة أو تغييرات في نطاق المشروع (Scope) تجعل هذه الفكرة تتميز عن سابقاتها وتستحق القبول كفكرة جديدة ومبتكرة.
      ''';

    try {
      final response = await _generativeModel.generateContent([
        Content.text(prompt),
      ]);
      return response.text ??
          'عذراً، لم أتمكن من توليد اقتراحات للتحسين حالياً.';
    } catch (e) {
      return 'لا تتوفر اقتراحات حالياً، يرجى مراجعة القسم المختص.';
    }
  }
}
