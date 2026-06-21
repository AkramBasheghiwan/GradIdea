import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/add_paper.dart';

class ApiService {
  static const String _baseUrl =
      'https://ideamanagementsystembackend-production.up.railway.app/api/v1';

  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  // ==========================================
  // Validate Idea
  // ==========================================
  Future<ValidationResponse> validateIdea(IdeaSubmit idea) async {
    try {
      // 1. طباعة البيانات المرسلة للتأكد من سلامتها قبل إرسالها
      log('📤 البيانات المرسلة إلى السيرفر: ${idea.toJson()}');

      final response = await _dio.post('/validate/', data: idea.toJson());

      return ValidationResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      if (e.response != null) {
        log('📋 [تفاصيل خطأ السيرفر 422 الدقيقة]:');
        log('كود الحالة (Status Code): ${e.response?.statusCode}');
        log('محتوى الخطأ (Response Data): ${e.response?.data}');
      } else {
        log('❌ لم يتم استلام أي رد من السيرفر (مشكلة شبكة أو سيرفر مغلق)');
      }

      log('validateIdea Dio Error', error: e, stackTrace: stackTrace);
      throw _mapDioException(e);
    } catch (e, stackTrace) {
      log('validateIdea Unknown Error', error: e, stackTrace: stackTrace);
      throw const ServerException('حدث خطأ غير متوقع أثناء فحص الفكرة');
    }
  }

  // ==========================================
  // Add Paper
  // ==========================================
  Future<PaperResponse> addPaper(PaperCreate paper) async {
    try {
      final response = await _dio.post('/papers/', data: paper.toJson());

      return PaperResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      log('addPaper Dio Error', error: e, stackTrace: stackTrace);

      throw _mapDioException(e);
    } catch (e, stackTrace) {
      log('addPaper Unknown Error', error: e, stackTrace: stackTrace);

      throw const ServerException(
        'حدث خطأ غير متوقع أثناء إضافة الورقة البحثية',
      );
    }
  }

  // ==========================================
  // 5. دالة تعديل ورقة بحثية (Update / PUT)
  // ==========================================
  Future<void> updatePaper(
    String supabaseId,
    UpdatePaperRequest updatedPaper,
  ) async {
    try {
      // نرسل الطلب إلى المسار المتوقع مثل: /papers/id/
      final response = await _dio.patch(
        '/papers/$supabaseId',
        data: updatedPaper.toJson(),
      );

      if (response.statusCode == 200) {
        // السيرفر يعيد غالباً البيانات المعدلة بعد النجاح
      }
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  // ==========================================
  // 6. دالة حذف ورقة بحثية (Delete / DELETE)
  // ==========================================
  Future<bool> deletePaper(String paperId) async {
    try {
      final response = await _dio.delete('/papers/$paperId');

      // في الغالب يعيد السيرفر كود 200 أو 204 عند الحذف الناجح
      if (response.statusCode == 200 || response.statusCode == 204) {
        log('✅ تم حذف الورقة بنجاح.');
        return true;
      }
    } on DioException catch (e) {
      log('====================');
      log('Status Code: ${e.response?.statusCode}');
      log('Response: ${e.response?.data}');
      log('Request: ${e.requestOptions.uri}');
      log('====================');
      throw _mapDioException(e);
    }
    return false;
  }

  // ==========================================
  // Dio Exception Mapper
  // ==========================================
  Exception _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkException('انتهت مهلة الاتصال بالخادم');

      case DioExceptionType.sendTimeout:
        return const NetworkException('انتهت مهلة إرسال البيانات');

      case DioExceptionType.receiveTimeout:
        return const NetworkException('انتهت مهلة استقبال البيانات');

      case DioExceptionType.connectionError:
        return const NetworkException('تعذر الاتصال بالإنترنت');

      case DioExceptionType.cancel:
        return const ServerException('تم إلغاء الطلب');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response);

      case DioExceptionType.badCertificate:
        return const ServerException('شهادة الأمان غير صالحة');

      case DioExceptionType.unknown:
        return const ServerException('حدث خطأ غير متوقع');
    }
  }

  Exception _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    final message = data is Map<String, dynamic>
        ? data['message']?.toString()
        : null;

    switch (statusCode) {
      case 400:
        return ServerException(message ?? 'بيانات الطلب غير صحيحة');

      case 401:
        return const UnauthorizedException('غير مصرح لك بتنفيذ هذا الإجراء');

      case 403:
        return const ForbiddenException('ليس لديك صلاحية للوصول');

      case 404:
        return const ServerException('المورد المطلوب غير موجود');

      case 409:
        return ServerException(message ?? 'تعارض في البيانات');

      case 422:
        return ServerException(message ?? 'فشل التحقق من صحة البيانات');

      case 500:
        return const ServerException('حدث خطأ في الخادم');

      default:
        return ServerException(message ?? 'حدث خطأ غير متوقع');
    }
  }
}
