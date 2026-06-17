import 'dart:developer';
import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppSettingsApiService {
  Future<bool> hasProject();
  Future<bool> canUploadProject();
  Future<bool> hasProposal();
  Future<bool> canUploadProposal();
}

class AppSettingsApiServiceImpl implements AppSettingsApiService {
  final SupabaseClient supabase;

  AppSettingsApiServiceImpl(this.supabase);

  Future<bool> _getSetting(String key) async {
    try {
      final response = await supabase.from('app_settings').select(key).single();

      return response[key] as bool;
    } on PostgrestException catch (e) {
      log(e.message);

      throw const ServerException('فشل في جلب الإعدادات');
    } catch (e) {
      log(e.toString());

      throw const ServerException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<bool> canUploadProject() {
    return _getSetting('can_upload_projects');
  }

  @override
  Future<bool> canUploadProposal() {
    return _getSetting('can_upload_proposal');
  }

  @override
  Future<bool> hasProject() async {
    try {
      final response = await supabase
          .from('users')
          .select('has_project, role')
          .eq('id', supabase.auth.currentUser!.id)
          .single();

      final hasProject = response['has_project'];
      final role = response['role'];

      if (role == AppRoles.admin || role == AppRoles.headOfDepartment) {
        return true;
      }

      return hasProject == false;
    } on PostgrestException catch (e) {
      log(e.message);

      throw const ServerException('فشل في جلب الإعدادات');
    } catch (e) {
      log(e.toString());

      throw const ServerException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<bool> hasProposal() async {
    try {
      final response = await supabase
          .from('users')
          .select('has_proposal, role')
          .eq('id', supabase.auth.currentUser!.id)
          .single();

      final hasProposal = response['has_proposal'];
      final role = response['role'];

      if (role == AppRoles.admin || role == AppRoles.headOfDepartment) {
        return true;
      }

      return hasProposal == false;
    } on SocketException {
      throw const ServerException('لايوجد اتصال انترنت ');
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        'حدث خطا غير متوقع اثنا تعديل حاله المشروع${e.toString()}',
      );
    }
  }
}
