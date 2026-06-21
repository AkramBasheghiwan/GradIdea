import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/app_secrets.dart';
import 'package:graduation_management_idea_system/core/services/api_service/api_service.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';

abstract class IdeaValidationByApiService {
  Future<ValidationResponse> validateIdea(IdeaSubmit ideaText);
  Future<String> getAiEnhancements(
    IdeaSubmit studentIdea,
    List<SimilarPaperMatch> oldProjects,
  );
}

class IdeaValidationByApiServiceImpl implements IdeaValidationByApiService {
  late ApiService apiService;
  late GenerativeModel _generativeModel;
  final String _apiKey = AppSecrets.geminiApiKey;

  IdeaValidationByApiServiceImpl() {
    apiService = ApiService();
    _generativeModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
    );
  }
  @override
  Future<ValidationResponse> validateIdea(IdeaSubmit ideaText) async {
    try {
      log('==============================');
      log('🚀 بدء فحص الفكرة');
      log('💡 Idea: $ideaText');

      final response = await apiService.validateIdea(ideaText);

      log('==============================');
      log('📦 Response كامل من API: $response');

      log('🧠 isNovel: ${response.isNovel}');
      log('📄 message: ${response.message}');
      log('📚 similarPapers length: ${response.similarPapers?.length ?? 0}');

      if (response.isNovel) {
        log('⚠️ الفكرة غير مبتكرة - خروج مبكر');
        return ValidationResponse(isNovel: true, message: response.message);
      }

      final dataList = response.similarPapers ?? [];

      log('==============================');
      log('📊 بدء معالجة المشاريع المشابهة');
      log('عدد العناصر: ${dataList.length}');

      final List<SimilarPaperMatch> similarProjects = [];
      double highestScore = 0;

      for (int i = 0; i < dataList.length; i++) {
        final item = dataList[i];

        final similarityPercentage = item.similarityScore * 100;

        log('------------------------------');
        log('🔢 Index: $i');
        log('📌 Title: ${item.title}');
        log('📈 Raw Score: ${item.similarityScore}');
        log('📊 Percentage: ${similarityPercentage.toStringAsFixed(2)}%');

        if (item.similarityScore >= 0.75) {
          log('✅ تم قبول المشروع (>= 0.75)');

          highestScore = item.similarityScore > highestScore
              ? item.similarityScore
              : highestScore;

          similarProjects.add(
            SimilarPaperMatch(
              externalId: item.externalId,
              abstract: item.abstract,
              title: item.title,
              similarityScore: similarityPercentage,
            ),
          );
        } else {
          log('❌ تم تجاهله (< 0.75)');
        }
      }
      highestScore = highestScore * 100;
      log('==============================');
      log('🏁 النتيجة النهائية');
      log('⭐ Highest Score: $highestScore ');
      log('📦 Similar Projects Count: ${similarProjects.length}');

      final result = ValidationResponse(
        isNovel: response.isNovel,
        message: response.message,
        highestScore: highestScore,
        similarPapers: similarProjects,
      );

      log('✅ تم إنشاء ValidationResponse بنجاح');
      log('==============================');

      return result;
    } catch (e, stackTrace) {
      log('==============================');
      log('❌ ERROR في validateIdea');
      log('Error: $e');
      log('StackTrace: $stackTrace');
      log('==============================');

      throw ServerException('حدث خطأ أثناء فحص الفكرة');
    }
  }

  @override
  Future<String> getAiEnhancements(
    IdeaSubmit studentIdea,
    List<SimilarPaperMatch> oldProjects,
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
            // log('📝 Project Description: ${project.description}');

            return '''
الاسم: ${project.title}

''';
          })
          .join('\n');

      final prompt =
          '''
أنت مستشار أكاديمي في كلية تقنية المعلومات.

🎯 المهمة:
اقترح 3 تحسينات تقنية تجعل فكرة الطالب أكثر تميزًا وغير مكررة مقارنة بالمشاريع المشابهة.

📌 فكرة الطالب:
"${studentIdea.title + studentIdea.abstract + studentIdea.keywords}"

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
