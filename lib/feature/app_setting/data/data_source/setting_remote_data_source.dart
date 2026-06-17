import 'dart:developer';
import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/feature/app_setting/data/model/setting_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppSettingRemoteDataSource {
  Future<AppSettingModel> get();

  Future<void> update({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  });

  Future<void> clearSupervisorCurrentGroup();
}

class AppSettingRemoteDataSourceImpl implements AppSettingRemoteDataSource {
  final SupabaseClient supabase;

  AppSettingRemoteDataSourceImpl(this.supabase);

  @override
  Future<AppSettingModel> get() async {
    final response = await supabase
        .from('app_settings')
        .select()
        .eq('id', 1)
        .single();

    return AppSettingModel.fromJson(response);
  }

  @override
  Future<void> update({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  }) async {
    final data = <String, dynamic>{};

    if (maxGroup != null) {
      data['max_group'] = maxGroup;
    }

    if (canUploadProjects != null) {
      data['can_upload_projects'] = canUploadProjects;
    }

    if (canUploadProposal != null) {
      data['can_upload_proposal'] = canUploadProposal;
    }

    if (data.isEmpty) return;

    await supabase.from('app_settings').update(data).eq('id', 1);
  }

  @override
  Future<void> clearSupervisorCurrentGroup() async {
    try {
      log('==============================');
      log('بدء تصفير عدد المجموعات الحالية للمشرفين');

      await supabase.rpc('clear_supervisor_current_groups');

      //  await supabase
      //     .from('supervisors_details')
      //     .update({'current_groups_count': 0})
      //     .gte('current_groups_count', 0);

      log('✅ تم تصفير عدد المجموعات بنجاح');

      log('==============================');
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } on PostgrestException catch (e) {
      log('Message: ${e.message}');
      log('Code: ${e.code}');
      log('Details: ${e.details}');
      log('Hint: ${e.hint}');

      throw ServerException('فشل في تصفير عدد المجموعات: ${e.message}');
    } catch (e, stackTrace) {
      log('Error: $e');
      log('StackTrace: $stackTrace');

      throw const ServerException(
        'حدث خطأ غير متوقع أثناء تصفير عدد المجموعات.',
      );
    }
  }
}
