import 'dart:developer';
import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppFileUpload {
  static Future<String> uploadFile(File file, SupabaseClient supabase) async {
    try {
      final fileExtension = file.path.split('.').last;
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_project.$fileExtension';

      await supabase.storage.from('archive_files').upload(fileName, file);

      final fileUrl = supabase.storage
          .from('archive_files')
          .getPublicUrl(fileName);
      return fileUrl;
    } on StorageException catch (e) {
      throw ServerException('فشل رفع الملف إلى الخادم: ${e.message}');
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت لرفع الملف.');
    } catch (e) {
      log('حدث خطا غير متوقع اثناء رفع الملف');
      throw ServerException('حدث خطأ غير متوقع أثناء رفع الملف: $e');
    }
  }

  static Future<String> updateFile(
    File file,
    String oldFilePath,
    SupabaseClient supabase,
  ) async {
    try {
      log('==============================');
      log('🚀 بدء رفع/تحديث الملف');

      // ===============================
      // 🧹 تجهيز المسارات
      // ===============================
      final newFileName =
          '${DateTime.now().millisecondsSinceEpoch}_project.${file.path.split('.').last}';

      final newPath = newFileName;

      final cleanOldPath = oldFilePath.replaceFirst(
        supabase.storage.from('archive_files').getPublicUrl(''),
        '',
      );

      log('📁 New Path: $newPath');
      log('📁 Old Path: $cleanOldPath');

      // ===============================
      // 📤 رفع الملف الجديد أولاً
      // ===============================
      log('📤 Uploading new file...');

      await supabase.storage
          .from('archive_files')
          .upload(newPath, file, fileOptions: const FileOptions(upsert: false));

      log('✅ تم رفع الملف الجديد');

      // ===============================
      // 🗑 حذف الملف القديم (بعد نجاح الرفع فقط)
      // ===============================
      if (cleanOldPath.isNotEmpty) {
        try {
          log('🗑 حذف الملف القديم...');

          await supabase.storage.from('archive_files').remove([cleanOldPath]);

          log('✅ تم حذف الملف القديم');
        } catch (e) {
          log('⚠️ فشل حذف الملف القديم (غير مؤثر): $e');
        }
      }

      // ===============================
      // 🔗 رابط الملف الجديد
      // ===============================
      final url = supabase.storage.from('archive_files').getPublicUrl(newPath);

      log('🔗 Public URL: $url');
      log('==============================');

      return url;
    } on StorageException catch (e) {
      log('❌ StorageException: ${e.message}');
      throw ServerException('فشل رفع الملف: ${e.message}');
    } on SocketException {
      throw const ServerException('لا يوجد اتصال بالإنترنت.');
    } catch (e) {
      log('💥 Unexpected Error: $e');
      throw ServerException('خطأ غير متوقع: $e');
    }
  }

  static String extractPathFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final fullPath = uri.pathSegments
          .skipWhile((e) => e != 'object')
          .skip(2)
          .join('/');
      return fullPath.replaceFirst('archive_files/', '');
    } catch (e) {
      throw const ServerException('فشل استخراج مسار الملف');
    }
  }
}
