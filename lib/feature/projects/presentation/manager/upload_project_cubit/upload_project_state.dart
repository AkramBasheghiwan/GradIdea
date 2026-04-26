import 'dart:io';

enum UploadProjectStatus { initial, loading, success, error }

class UploadProjectState {
  final UploadProjectStatus status;
  final String? errorMessage;

  final File? selectedFile;
  final String? fileName;

  UploadProjectState({
    this.status = UploadProjectStatus.initial,
    this.errorMessage,
    this.selectedFile,
    this.fileName,
  });

  // دالة copyWith لتحديث أجزاء معينة من الحالة دون التأثير على الباقي
  UploadProjectState copyWith({
    UploadProjectStatus? status,
    String? errorMessage,
    File? selectedFile,
    String? fileName,
    bool clearFile = false, // نستخدمها صراحة عندما نريد حذف الملف
  }) {
    return UploadProjectState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFile: clearFile ? null : (selectedFile ?? this.selectedFile),
      fileName: clearFile ? null : (fileName ?? this.fileName),
    );
  }
}
