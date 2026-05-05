import 'package:google_generative_ai/google_generative_ai.dart';

class ExtractTextFromeImage {
  late GenerativeModel _generativeModel;

  ExtractTextFromeImage() {
    _generativeModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: 'AIzaSyAmqZtjZHYAV4Z3HNVwHn60yVNFbkiPBgk',
    );
  }

  Future<String> extractTextFromImage(DataPart imageBytes) async {
    try {
      final content = [
        Content.multi([
          TextPart(
            "أنت خبير في تلخيص مشاريع التخرج التقنية. "
            "المهمة: استخرج النص من هذه الصورة ثم لخصه بأسلوب احترافى وجذاب. "
            "الشروط: "
            "1. ألا يتجاوز الملخص 150 كلمة. "
            "2. يجب أن يبرز الملخص (اسم المشروع، المشكلة التي يحلها، والتقنيات المستخدمة إن وجدت). "
            "3. اللغة: العربية الفصحى. "
            "4. المخرجات: النص الملخص فقط، بدون أي جمل جانبية مثل 'إليك الملخص' أو 'تم الاستخراج'.",
          ),
          imageBytes,
        ]),
      ];

      final response = await _generativeModel.generateContent(content);

      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        throw Exception('لم يستطع الذكاء الاصطناعي قراءة النص');
      }
    } on GenerativeAIException catch (e) {
      throw Exception('فشل الاتصال بـ Gemini: ${e.message}');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
