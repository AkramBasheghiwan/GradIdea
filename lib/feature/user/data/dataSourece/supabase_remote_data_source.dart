import 'dart:io';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserSupabaseRemoteDataSource {
  Future<List<UserModel>> getAllUsersByRole(String role);
  Future<void> deleteUser(String userId);
  Future<void> updateUserRole(String userId, String newRole);
  Future<List<UserModel>> searchUsers({
    required String query,
    required int page,
  });
}

class UserSupabaseRemoteDataSourceImpl implements UserSupabaseRemoteDataSource {
  // استبدلنا Firestore و FirebaseAuth بـ SupabaseClient
  final SupabaseClient supabase;

  UserSupabaseRemoteDataSourceImpl({required this.supabase});

  // ==========================================
  // 1. جلب جميع المستخدمين حسب الرتبة
  // ==========================================
  @override
  Future<List<UserModel>> getAllUsersByRole(String role) async {
    try {
      final response = await supabase
          .from(AppConstatnce.userCollection)
          .select()
          .eq('role', role);

      // تحويل النتيجة (List<dynamic>) إلى List<UserModel>
      return (response as List).map((data) {
        return UserModel.fromSupabaseMap(data, true);
      }).toList();
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on PostgrestException catch (e) {
      throw ServerException(_handlePostgrestException(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  // ==========================================
  // 2. حذف مستخدم
  // ==========================================
  @override
  Future<void> deleteUser(String userId) async {
    try {
      // استعلام الحذف في Supabase
      await supabase
          .from(AppConstatnce.userCollection)
          .delete()
          .eq('id', userId);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on PostgrestException catch (e) {
      throw ServerException(_handlePostgrestException(e));
    } catch (e) {
      throw ServerException('حدث خطأ أثناء الحذف: ${e.toString()}');
    }
  }

  // ==========================================
  // 3. تحديث رتبة مستخدم
  // ==========================================
  @override
  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      // استعلام التحديث في Supabase
      await supabase
          .from(AppConstatnce.userCollection)
          .update({'role': newRole})
          .eq('id', userId);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on PostgrestException catch (e) {
      throw ServerException(_handlePostgrestException(e));
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحديث الدور: ${e.toString()}');
    }
  }
  // ==========================================
  // 3.البحث عن مستخدم
  // ==========================================

  @override
  Future<List<UserModel>> searchUsers({
    required String query,
    required int page,
  }) async {
    try {
      final String safeQuery = query.trim();
      const int limit = 15;

      final int from = page * limit;
      final int to = from + limit - 1;

      final response = await supabase
          .from(AppConstatnce.userCollection)
          .select()
          .or(
            'name.ilike.%$safeQuery%,email.ilike.%$safeQuery%,phone.ilike.%$safeQuery%',
          )
          .range(from, to);

      return (response as List).map((data) {
        return UserModel.fromSupabaseMap(data, true);
      }).toList();
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      throw ServerException(_handlePostgrestException(e));
    } catch (e) {
      throw ServerException('حدث خطأ أثناء البحث: $e');
    }
  }

  // ==========================================
  // 🛡️ مترجم أخطاء Supabase (البديل لـ _handleFirebaseException)
  // ==========================================
  String _handlePostgrestException(PostgrestException exception) {
    switch (exception.code) {
      case '42501': // يعادل 'permission-denied' في فايربيس
        return 'ليس لديك الصلاحية (RLS) للوصول إلى هذه البيانات أو تعديلها.';
      case 'PGRST116': // يعادل 'not-found' في فايربيس
        return 'لم يتم العثور على البيانات المطلوبة.';
      case '23505': // خطأ البيانات المكررة
        return 'هذه البيانات موجودة مسبقاً.';
      default:
        return 'حدث خطأ في الخادم: ${exception.message}';
    }
  }
}
