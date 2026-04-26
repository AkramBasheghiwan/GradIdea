



import 'dart:io';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppFileUpload{

static Future<String>uploadFile(File file ,SupabaseClient supabase)async{
  try {
      final fileExtension = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_project.$fileExtension';
      
      await supabase.storage.from('archive_files').upload(fileName, file);
      
      final fileUrl = supabase.storage.from('archive_files').getPublicUrl(fileName);
      return fileUrl;
    } on StorageException catch (e) {
      throw ServerException('فشل رفع الملف إلى الخادم: ${e.message}');
    } on SocketException {
      throw  const ServerException('لا يوجد اتصال بالإنترنت لرفع الملف.');
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع أثناء رفع الملف: $e');
    }
  }
}