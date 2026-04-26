import 'dart:io';

abstract class FileServices {
  Future<String> uploadFile(String path, File file);
  Future<void> deleteFile(String path);
  Future<void> updateFile(String path, File file);
  Future<String> downloadFile(String path);
}
