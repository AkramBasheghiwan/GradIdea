// 1. البيانات المطلوبة عند إنشاء أو إضافة ورقة جديدة
class PaperCreate {
  final int externalId;
  final String title;
  final String abstract;
  final String?
  keywords; // علامة الاستفهام لأن الحقل اختياري في السيرفر ويمكن أن يكون null

  PaperCreate({
    required this.externalId,
    required this.title,
    required this.abstract,
    this.keywords,
  });

  factory PaperCreate.fromJson(Map<String, dynamic> json) {
    return PaperCreate(
      externalId: json['external_id'] as int,
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      keywords: json['keywords'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'external_id': externalId,
      'title': title,
      'abstract': abstract,
      'keywords': keywords,
    };
  }
}

// 2. البيانات العائدة عند جلب أو استعراض الورقة البحثية
class PaperResponse {
  final int id;
  final int externalId;
  final String title;
  final String abstract;
  final String? keywords;

  PaperResponse({
    required this.id,
    required this.externalId,
    required this.title,
    required this.abstract,
    this.keywords,
  });

  factory PaperResponse.fromJson(Map<String, dynamic> json) {
    return PaperResponse(
      id: json['id'] as int,
      externalId: json['external_id'] as int,
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      keywords: json['keywords'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'title': title,
      'abstract': abstract,
      'keywords': keywords,
    };
  }
}
