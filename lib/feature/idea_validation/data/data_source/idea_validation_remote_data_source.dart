import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/app_secrets.dart';

import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/validation_result_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IdeaValidationRemoteDataSource {
  Future<ValidationResultEntity> validateIdea(String ideaText);
  Future<String> getAiEnhancements(
    String studentIdea,
    List<SimilarProjectEntity> oldProjects,
  );
}

class IdeaValidationRemoteDataSourceImpl
    implements IdeaValidationRemoteDataSource {
  final SupabaseClient supabase;

  final String _apiKey = AppSecrets.geminiApiKey;

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

  // 🔹 توليد الـ Embedding
  Future<List<double>> _generateEmbeddingVector(String ideaText) async {
    try {
      final content = Content.text(ideaText);

      final embeddingResult = await _embeddingModel.embedContent(
        content,
        taskType: TaskType.retrievalDocument,
        outputDimensionality: 768,
      );

      log('✅ Embedding generated');
      return embeddingResult.embedding.values;
    } on GenerativeAIException catch (e) {
      throw ServerException(
        'فشل الذكاء الاصطناعي في تحليل المشروع: ${e.message}',
      );
    } catch (e) {
      throw ServerException('حدث خطأ أثناء معالجة النص: $e');
    }
  }

  // 🔥 الدالة الأساسية
  // @override
  // Future<ValidationResultEntity> validateIdea(String ideaText) async {
  //   try {
  //     log('==============================');
  //     log('🚀 بدء فحص الفكرة');
  //     log('💡 Idea: $ideaText');

  //     // 1. توليد Embedding
  //     final queryVector = await _generateEmbeddingVector(ideaText);

  //     // 2. استدعاء Supabase RPC
  //     final List<dynamic> result = await supabase.rpc(
  //       'match_projects',
  //       params: {'query_embedding': queryVector, 'match_count': 5},
  //     );

  //     log('📦 Returned: ${result.length} projects');

  //     List<SimilarProjectEntity> similarProjects = [];

  //     for (var item in result) {
  //       final data = item as Map<String, dynamic>;

  //       final similarity = (data['similarity'] as num?)?.toDouble() ?? 0.0;

  //       final similarityPercentage = similarity * 100;

  //       final matchType = data['match_type'] ?? 'ok';

  //       log('--------------------------------');
  //       log('Project: ${data['name']}');
  //       log('Similarity: ${similarityPercentage.toStringAsFixed(2)}%');
  //       log('Type: $matchType');

  //       // ✅ نأخذ فقط المشاريع المهمة
  //       if (matchType == 'duplicate' || matchType == 'warning') {
  //         similarProjects.add(
  //           SimilarProjectEntity(
  //             id: data['id']?.toString() ?? '',
  //             title: data['name'] ?? 'بدون عنوان',
  //             description: data['description'] ?? '',
  //             similarityPercentage: similarityPercentage,
  //             department: data['department'] ?? '',
  //             year: data['year'],
  //           ),
  //         );
  //       }
  //     }

  //     log('🎯 Final count: ${similarProjects.length}');

  //     // ✅ لا يوجد تشابه
  //     if (similarProjects.isEmpty) {
  //       return ValidationResultEntity(isUnique: true);
  //     }

  //     // ❌ يوجد تشابه
  //     return ValidationResultEntity(
  //       isUnique: false,
  //       similarProjects: similarProjects,
  //     );
  //   } on PostgrestException catch (e) {
  //     log('❌ Supabase Error: ${e.message}');
  //     throw ServerException('فشل الاتصال بقاعدة البيانات: ${e.message}');
  //   } on GenerativeAIException catch (e) {
  //     log('❌ AI Error: ${e.message}');
  //     throw ServerException('فشل تحليل الفكرة: ${e.message}');
  //   } catch (e) {
  //     log('❌ Unknown Error: $e');
  //     throw ServerException('حدث خطأ غير متوقع: $e');
  //   }
  // }

  @override
  Future<ValidationResultEntity> validateIdea(String ideaText) async {
    try {
      log('==============================');
      log('🚀 بدء فحص الفكرة');
      log('💡 Idea: $ideaText');

      // 1. توليد Embedding
      final queryVector = await _generateEmbeddingVector(ideaText);

      // 2. استدعاء RPC
      final response = await supabase.rpc(
        'match_projects_hybrid',
        params: {
          'query_embedding': queryVector,
          'query_text': ideaText,
          'match_threshold': 0.75,
          'match_count': 5,
          'exclude_project_id': null,
        },
      );

      final List dataList = (response as List?) ?? [];

      log('📦 Returned: ${dataList.length} projects');

      if (dataList.isEmpty) {
        return ValidationResultEntity(isUnique: true);
      }

      List<SimilarProjectEntity> similarProjects = [];

      double highestScore = 0;

      for (var item in dataList) {
        final data = item as Map<String, dynamic>;

        final finalScore = (data['final_score'] as num?)?.toDouble() ?? 0.0;
        final similarityPercentage = finalScore * 100;
        final matchType = getMatchType(finalScore);
        highestScore = finalScore > highestScore ? finalScore : highestScore;

        log('--------------------------------');
        log('Project: ${data['name']}');
        log('Score: ${similarityPercentage.toStringAsFixed(2)}%');

        // ✅ فلترة ذكية حسب النسبة بدل النص
        if (finalScore >= 0.75) {
          similarProjects.add(
            SimilarProjectEntity(
              id: data['id']?.toString() ?? '',
              title: data['name'] ?? 'بدون عنوان',
              description: data['description'] ?? '',
              similarityPercentage: similarityPercentage,
              department: data['department'] ?? '',
              year: data['year'],
              matchType: matchType,
            ),
          );
        }
      }

      log('🎯 Highest Score: ${(highestScore * 100).toStringAsFixed(2)}%');

      // ✅ القرار النهائي
      final isUnique = highestScore < 0.75;

      return ValidationResultEntity(
        isUnique: isUnique,
        similarProjects: similarProjects,
      );
    } catch (e) {
      log('❌ Error: $e');
      throw ServerException('حدث خطأ أثناء فحص الفكرة');
    }
  }

  @override
  Future<String> getAiEnhancements(
    String studentIdea,
    List<SimilarProjectEntity> oldProjects,
  ) async {
    try {
      log('==============================');
      log('🚀 AI Enhancement Started');
      log('💡 Student Idea: $studentIdea');

      final limitedProjects = oldProjects.take(3).toList();
      log('📚 Similar Projects Count: ${limitedProjects.length}');

      final context = limitedProjects
          .map((project) {
            log('--------------------------------');
            log('📌 Project Title: ${project.title}');
            log('📝 Project Description: ${project.description}');

            return '''
الاسم: ${project.title}
الوصف: ${project.description}
''';
          })
          .join('\n');

      final prompt =
          '''
أنت مستشار أكاديمي في كلية تقنية المعلومات.

🎯 المهمة:
اقترح 3 تحسينات تقنية تجعل فكرة الطالب أكثر تميزًا وغير مكررة مقارنة بالمشاريع المشابهة.

📌 فكرة الطالب:
"$studentIdea"

📚 المشاريع المشابهة:
$context

⚠️ التعليمات:
- اكتب 3 تحسينات فقط
- كل تحسين يكون جملة واحدة واضحة وقوية
- تجنب الإطالة أو الشرح الزائد
- لا تستخدم كلام عام مثل "تحسين الأداء" بدون توضيح
- كل تحسين لازم يكون تقني ومحدد وقابل للتطبيق مباشرة
- لا تكرر الأفكار
- ركز على الجوانب التي تجعل المشروع فريد ومبتكر
''';

      log('🧠 Prompt Ready');
      log('------------------------------');
      log(prompt);

      final response = await _generativeModel.generateContent([
        Content.text(prompt),
      ]);

      final result = response.text ?? 'لا توجد اقتراحات حالياً';

      log('==============================');
      log('🤖 AI Response Received');
      log(result);
      log('==============================');

      return result;
    } catch (e) {
      log('❌ AI Error: $e');
      return 'تعذر توليد الاقتراحات حالياً';
    }
  }
}
// الكود ذا عبار عن داله فيه خوارميه cosinSmilarity لكشف التشابه المشاريع
// CREATE OR REPLACE FUNCTION match_projects (
//   query_embedding vector(768),
//   match_threshold float DEFAULT 0.85,
//   match_count int DEFAULT 10,
//   exclude_project_id uuid DEFAULT NULL
// )
// RETURNS TABLE (
//   id uuid,
//   name text,
//   description text,
//   department text,
//   year text,
//   students jsonb,
//   supervisor text,
//   fileurl text,
//   similarity float,
//   match_type text
// )
// LANGUAGE sql
// AS $$
//   SELECT
//     p.id,
//     p.name,
//     p.description,
//     p.department,
//     p.year,
//     p.students,
//     p.supervisor,
//     p.fileurl,
//     similarity,
//     CASE
//       WHEN similarity >= 0.90 THEN 'duplicate'
//       WHEN similarity >= 0.85 THEN 'warning'
//       ELSE 'ok'
//     END AS match_type
//   FROM (
//     SELECT
//       p.*,
//       1 - (p.embedding_vector <=> query_embedding) AS similarity
//     FROM projects p
//     WHERE 
//       p.status = 'approved'
//       AND (exclude_project_id IS NULL OR p.id != exclude_project_id)
//   ) p
//   WHERE similarity >= match_threshold
//   ORDER BY similarity DESC
//   LIMIT match_count;
// $$;


// انشاء index
// CREATE INDEX IF NOT EXISTS idx_projects_embedding
// ON projects
// USING ivfflat (embedding_vector vector_cosine_ops)
// WITH (lists = 100);

//ANALYZE projects;


// CREATE OR REPLACE FUNCTION match_projects_hybrid (
//   query_embedding vector(768),
//   query_text text,
//   match_threshold float DEFAULT 0.75,
//   match_count int DEFAULT 10,
//   exclude_project_id uuid DEFAULT NULL
// )
// RETURNS TABLE (
//   id uuid,
//   name text,
//   description text,
//   department text,
//   year text,
//   students jsonb,
//   supervisor text,
//   fileurl text,
//   similarity float,
//   text_score float,
//   final_score float,
//   match_type text
// )
// LANGUAGE sql
// AS $$
//   SELECT
//     p.id,
//     p.name,
//     p.description,
//     p.department,
//     p.year,
//     p.students,
//     p.supervisor,
//     p.fileurl,

//     p.similarity,
//     p.text_score,

//     (p.similarity * 0.7 + p.text_score * 0.3) AS final_score,

//     CASE
//       WHEN (p.similarity * 0.7 + p.text_score * 0.3) >= 0.90 THEN 'exact_duplicate'
//       WHEN (p.similarity * 0.7 + p.text_score * 0.3) >= 0.85 THEN 'high_similarity'
//       WHEN (p.similarity * 0.7 + p.text_score * 0.3) >= 0.75 THEN 'medium_similarity'
//       ELSE 'low_similarity'
//     END AS match_type

//   FROM (
//     SELECT
//       pr.*,

//       (1 - (pr.embedding_vector <=> query_embedding)) AS similarity,

//       ts_rank(
//         to_tsvector('simple', pr.name || ' ' || pr.description),
//         plainto_tsquery('simple', query_text)
//       ) AS text_score

//     FROM projects pr
//     WHERE 
//       pr.status = 'approved'
//       AND (exclude_project_id IS NULL OR pr.id != exclude_project_id)

//       -- 🔥 أهم سطر (فلترة باستخدام index)
//       AND (pr.embedding_vector <=> query_embedding) <= 0.4

//     ORDER BY pr.embedding_vector <=> query_embedding
//     LIMIT 50 -- نجيب أفضل 50 فقط ثم نحسب النهائي
//   ) p

//   WHERE (p.similarity * 0.7 + p.text_score * 0.3) >= match_threshold
//   ORDER BY final_score DESC
//   LIMIT match_count;
// $$;  
