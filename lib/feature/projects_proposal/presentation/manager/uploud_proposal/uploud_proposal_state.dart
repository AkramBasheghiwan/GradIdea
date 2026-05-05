import 'dart:io';

enum UploadProposalStatus { initial, loading, success, error }

class UploadProposalState {
  final UploadProposalStatus status;
  final String? errorMessage;

  final File? selectedFile;
  final String? fileName;

  UploadProposalState({
    this.status = UploadProposalStatus.initial,
    this.errorMessage,
    this.selectedFile,
    this.fileName,
  });

  UploadProposalState copyWith({
    UploadProposalStatus? status,
    String? errorMessage,
    File? selectedFile,
    String? fileName,
    bool clearFile = false, // نستخدمها صراحة عندما نريد حذف الملف
  }) {
    return UploadProposalState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFile: clearFile ? null : (selectedFile ?? this.selectedFile),
      fileName: clearFile ? null : (fileName ?? this.fileName),
    );
  }
}
