import 'dart:developer';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/model/supervisor_state_analysis.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DashboardAnalysisSupervisorDataSource {
  Future<SupervisorStatisticsModel> getDashboardAnalysisData();
}

class DashboardAnalysisSupervisorDataSourceImpl
    implements DashboardAnalysisSupervisorDataSource {
  final SupabaseClient supabase;

  DashboardAnalysisSupervisorDataSourceImpl({required this.supabase});
  @override
  Future<SupervisorStatisticsModel> getDashboardAnalysisData() async {
    try {
      log('🚀 بدء جلب إحصائيات المشرف');

      final response = await supabase.rpc('get_supervisor_statis');

      log('📦 Response: $response');
      if (response is! List || response.isEmpty) {
        throw const ServerException('لم يتم إرجاع بيانات');
      }
      return SupervisorStatisticsModel.fromJson(
        response.first as Map<String, dynamic>,
      );
    } on PostgrestException catch (e, stackTrace) {
      log('❌ PostgrestException', error: e, stackTrace: stackTrace);

      _handlePostgrestException(e, 'جلب بيانات لوحة التحكم');

      throw ServerException(e.message);
    } catch (e, stackTrace) {
      log('💥 Unexpected Error', error: e, stackTrace: stackTrace);

      if (e is ServerException) rethrow;

      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  void _handlePostgrestException(PostgrestException e, String operationName) {
    final code = e.code;
    if (code == '42501') {
      throw const ServerException(
        'عذراً، ليس لديك صلاحية للوصول إلى هذه البيانات.',
      );
    } else if (code == '42601') {
      throw ServerException(
        'عذراً، هناك خطأ في استعلام قاعدة البيانات أثناء $operationName.',
      );
    } else if (code == '42P01') {
      throw ServerException(
        'عذراً، الجدول أو العمود المطلوب غير موجود أثناء $operationName.',
      );
    } else {
      throw ServerException(
        'حدث خطأ غير متوقع أثناء $operationName: ${e.message}',
      );
    }
  }
}
