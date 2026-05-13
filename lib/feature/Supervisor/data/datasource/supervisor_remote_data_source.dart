import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/data/model/project_group_model.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/data/model/supervisor_detail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';

abstract class SupervisorRemoteDataSource {
  Future<SupervisorDetailsModel> getSupervisorDetails();

  Future<void> updateMaxGroups(int newMaxCount);

  Future<List<ProjectGroupModel>> getSupervisorProposals();

  Future<void> respondToProposal({
    required int groupId,
    required String
    decision, // AppProjectsStatus.approved أو AppProjectsStatus.rejected
    String? rejectionReason,
  });
}

class SupabaseSupervisorDataSourceImpl implements SupervisorRemoteDataSource {
  final SupabaseClient supabase;

  SupabaseSupervisorDataSourceImpl({required this.supabase});

  // ==========================================
  // 1. جلب تفاصيل المشرف
  // ==========================================
  @override
  Future<SupervisorDetailsModel> getSupervisorDetails() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw const ServerException('يجب تسجيل الدخول أولاً.');

      final data = await supabase
          .from(AppConstatnce.supervisorsDetails)
          .select()
          .eq(AppConstatnce.id, user.id)
          .single();

      return SupervisorDetailsModel.fromSupabaseMap(data);
    } on PostgrestException catch (e) {
      _handlePostgrestException(e, 'جلب تفاصيل المشرف');
      throw ServerException(e.message); // لن يصل هنا عادة
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  // ==========================================
  // 2. تحديث الحد الأقصى للمجموعات
  // ==========================================
  @override
  Future<void> updateMaxGroups(int newMaxCount) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw const ServerException('يجب تسجيل الدخول أولاً.');

      if (newMaxCount < 1) {
        throw const ServerException(
          'يجب أن يكون الحد الأقصى مجموعة واحدة على الأقل.',
        );
      }

      await supabase
          .from(AppConstatnce.supervisorsDetails)
          .update({AppConstatnce.maxGroupcount: newMaxCount})
          .eq(AppConstatnce.id, user.id);
    } on PostgrestException catch (e) {
      _handlePostgrestException(e, 'تحديث عدد المجموعات');
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  // ==========================================
  // 3. جلب مقترحات المشاريع الموجهة للمشرف
  // ==========================================
  @override
  Future<List<ProjectGroupModel>> getSupervisorProposals() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw const ServerException('يجب تسجيل الدخول أولاً.');

      final response = await supabase
          .from('project_groups')
          .select()
          .eq('supervisor_id', user.id)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ProjectGroupModel.fromSupabaseMap(json))
          .toList();
    } on PostgrestException catch (e) {
      _handlePostgrestException(e, 'جلب المقترحات');
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  // ==========================================
  // 4. الرد على المقترح (قبول أو رفض)
  // ==========================================
  @override
  Future<void> respondToProposal({
    required int groupId,
    required String decision,
    String? rejectionReason,
  }) async {
    try {
      if (decision != AppProjectsStatus.approved &&
          decision != AppProjectsStatus.rejected) {
        throw const ServerException(
          'القرار غير صالح، يجب أن يكون قبول أو رفض.',
        );
      }

      final Map<String, dynamic> updateData = {'status': decision};

      if (decision == AppProjectsStatus.rejected) {
        if (rejectionReason == null || rejectionReason.trim().isEmpty) {
          throw const ServerException('يجب كتابة سبب الرفض لإفادة الطلاب.');
        }
        updateData['rejection_reason'] = rejectionReason.trim();
      } else {
        // إذا كان قبول، نمسح سبب الرفض القديم إن وجد
        updateData['rejection_reason'] = null;
      }

      await supabase
          .from('project_groups')
          .update(updateData)
          .eq('id', groupId);
    } on PostgrestException catch (e) {
      // هنا قد يحدث خطأ RLS إذا حاول المشرف تحديث مقترح لا يخصه
      if (e.code == '42501' || e.message.contains('policy')) {
        throw const ServerException('ليس لديك صلاحية للرد على هذا المقترح.');
      }
      _handlePostgrestException(e, 'الرد على المقترح');
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  // ==========================================
  // 🛡️ معالج أخطاء قاعدة البيانات (PostgrestException)
  // ==========================================
  void _handlePostgrestException(PostgrestException e, String operationName) {
    final code = e.code;
    final message = e.message.toLowerCase();

    // 1. أخطاء انقطاع الاتصال أو الشبكة
    if (message.contains('socket') ||
        message.contains('network') ||
        message.contains('timeout')) {
      throw const ServerException('تأكد من اتصالك بالإنترنت وحاول مرة أخرى.');
    }

    // 2. خطأ عدم العثور على بيانات (مثلاً المشرف ليس له سجل في supervisors_details)
    if (code == 'PGRST116') {
      throw ServerException('لا توجد بيانات متاحة لـ $operationName.');
    }

    // 3. خطأ انتهاك قيد البيانات (مثلاً إدخال نص في حقل أرقام)
    if (code == '23505' || message.contains('unique constraint')) {
      throw const ServerException('هذه البيانات موجودة مسبقاً.');
    }

    // 4. خطأ الصلاحيات (Row Level Security)
    if (code == '42501') {
      throw const ServerException('ليس لديك الصلاحية للقيام بهذه العملية.');
    }

    // 5. أي خطأ آخر من قاعدة البيانات
    throw ServerException('فشل $operationName: خطأ في الخادم ($code)');
  }
}
