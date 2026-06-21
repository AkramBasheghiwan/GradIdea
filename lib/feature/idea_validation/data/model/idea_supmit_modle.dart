// 1. البيانات المطلوبة لإرسال فكرة لفحصها
import 'package:equatable/equatable.dart';

class IdeaSubmit extends Equatable {
  final String title;
  final String abstract;
  final String keywords;

  const IdeaSubmit({
    required this.title,
    required this.abstract,
    required this.keywords,
  });

  // تحويل من JSON إلى Object
  factory IdeaSubmit.fromJson(Map<String, dynamic> json) {
    return IdeaSubmit(
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      keywords: json['keywords'] as String,
    );
  }

  // تحويل من Object إلى JSON لإرساله للسيرفر
  Map<String, dynamic> toJson() {
    return {'title': title, 'abstract': abstract, 'keywords': keywords};
  }

  @override
  List<Object> get props => [title, abstract, keywords];
}

// 2. نتيجة فحص الفكرة العائدة من السيرفر
class ValidationResponse extends Equatable {
  final bool isNovel;
  final String message;
  final List<SimilarPaperMatch>? similarPapers;
  final double? highestScore;
  const ValidationResponse({
    required this.isNovel,
    required this.message,
    this.similarPapers,
    this.highestScore,
  });

  factory ValidationResponse.fromJson(Map<String, dynamic> json) {
    return ValidationResponse(
      isNovel: json['is_novel'] as bool,
      message: json['message'] as String,
      similarPapers:
          (json['similar_papers'] as List<dynamic>?)
              ?.map(
                (e) => SimilarPaperMatch.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_novel': isNovel,
      'message': message,
      'similar_papers': similarPapers?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [isNovel, message];
}

// 3. نموذج الأبحاث المتشابهة المسترجعة داخل نتيجة الفحص
class SimilarPaperMatch extends Equatable {
  final String externalId;
  final String abstract;
  final String title;
  final double similarityScore;

  const SimilarPaperMatch({
    required this.externalId,
    required this.title,
    required this.abstract,
    required this.similarityScore,
  });

  factory SimilarPaperMatch.fromJson(Map<String, dynamic> json) {
    return SimilarPaperMatch(
      externalId: json['external_id'],
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      similarityScore: (json['similarity_score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'external_id': externalId,
      'title': title,
      'similarity_score': similarityScore,
    };
  }

  @override
  List<Object> get props => [externalId, title, similarityScore];
}
