// 1. البيانات المطلوبة عند إنشاء أو إضافة ورقة جديدة
class PaperCreate {
  final String externalId;
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
      externalId: json['external_id'],
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

class PaperResponse {
  final int id;
  final String externalId;
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
      externalId: json['external_id'],
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

class UpdatePaperRequest {
  final String title;
  final String abstract;
  final String keywords;

  UpdatePaperRequest({
    required this.title,
    required this.abstract,
    required this.keywords,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'abstract': abstract,
    'keywords': keywords,
  };
}
