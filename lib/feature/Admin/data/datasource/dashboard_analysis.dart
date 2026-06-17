import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/model/dashboard_analysis_modle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DashboardAnalysisRemoteDataSource {
  Future<DashboardAnalysisModle> fetchDashboardAnalysis();
}

class DashboardAnalysisRemoteDataSourceImp
    implements DashboardAnalysisRemoteDataSource {
  final SupabaseClient supabase;

  const DashboardAnalysisRemoteDataSourceImp(this.supabase);

  @override
  Future<DashboardAnalysisModle> fetchDashboardAnalysis() async {
    try {
      final response = await supabase.rpc('get_dashboard_stats').single();
      return DashboardAnalysisModle.fromMap(response);
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      _handleDatabaseError(e, 'جلب تحليلات لوحة التحكم');
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء جلب التحليلات: $e');
    }
  }

  void _handleDatabaseError(PostgrestException e, String operationName) {
    if (e.code == '42501') {
      throw ServerException(
        'عذراً، ليس لديك صلاحية للقيام بـ ($operationName).',
      );
    } else if (e.code == '23505') {
      throw const ServerException(
        'عذراً، البيانات التي تحاول الوصول إليها غير موجودة أو مكررة.',
      );
    } else if (e.code == '42601') {
      throw const ServerException(
        'عذراً، هناك خطأ في استعلام قاعدة البيانات أثناء ',
      );
    }
  }
}
