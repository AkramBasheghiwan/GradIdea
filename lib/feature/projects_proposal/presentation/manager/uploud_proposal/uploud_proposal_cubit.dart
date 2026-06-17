import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_state.dart';

// import 'package:dartz/dartz.dart';

class UploadProposalCubit extends Cubit<UploadProposalState> {
  ProjectProposalRepository repository;
  UploadProposalCubit({required this.repository})
    : super(UploadProposalState());

  // ==========================================
  // 1. دوال التعامل مع الملفات
  // ==========================================

  Future<void> pickProposalFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'zip'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String name = result.files.single.name;

        emit(state.copyWith(selectedFile: file, fileName: name));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UploadProposalStatus.error,
          errorMessage: "حدث خطأ أثناء اختيار الملف: $e",
        ),
      );
    }
  }

  void clearSelectedFile() {
    // مسح الملف من الحالة
    emit(state.copyWith(clearFile: true));
  }

  // ==========================================
  // 2. دالة إضافة مشروع جديد
  // ==========================================

  Future<void> submitProposal({
    required String name,
    required String description,
    required String department,
    required String year,
    required List<String> students,
    required String supervisor,
    required String supervisorId,
  }) async {
    emit(state.copyWith(status: UploadProposalStatus.loading));

    if (state.selectedFile == null) {
      emit(
        state.copyWith(
          status: UploadProposalStatus.error,
          errorMessage: "يرجى إرفاق ملف المشروع أولاً.",
        ),
      );
      return;
    }

    final result = await repository.uploudProjectsProposals(
      ProjectProposals(
        name: name,
        description: description,
        department: department,
        year: year,
        students: students,
        supervisor: supervisor,
        projectFile: state.selectedFile,
        idSupervisor: supervisorId,
        status: AppProjectsStatus.pending,
        // نمرر الملف للـ UseCase
      ),
    );

    result.fold(
      (failure) {
        if (failure is UploadDisabledFailure) {
          emit(
            state.copyWith(
              status: UploadProposalStatus.uploadDisabled,
              errorMessage: failure.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: UploadProposalStatus.error,
              errorMessage: failure.message,
            ),
          );
        }
      },
      (success) {
        emit(state.copyWith(status: UploadProposalStatus.success));
        clearSelectedFile(); // تفريغ الملف بعد النجاح
      },
    );

    // ==========================================
    // 3. دالة تعديل مشروع حالي
    // ==========================================
  }

  Future<void> updateProposal({
    String? fileUrl,
    required String id,
    required String name,
    required String description,
    required String department,
    required String year,
    required List<String> students,
    required String supervisor,
    required String supervisorId,

    File? newfle,
  }) async {
    emit(state.copyWith(status: UploadProposalStatus.loading));

    final result = await repository.updateProposal(
      ProjectProposals(
        fileUrl: fileUrl,
        id: id,
        name: name,
        description: description,
        department: department,
        year: year,
        students: students,
        supervisor: supervisor,
        projectFile: state.selectedFile,
        idSupervisor: supervisorId,
      ),
      newfle,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UploadProposalStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (success) {
        emit(state.copyWith(status: UploadProposalStatus.updateSucess));
        clearSelectedFile();
      },
    );
  }

  Future<void> deleteProposal(String proposalId, String fileUrl) async {
    emit(state.copyWith(status: UploadProposalStatus.loading));

    final resulte = await repository.deleteProjectProposal(proposalId, fileUrl);

    resulte.fold(
      (failure) => emit(
        state.copyWith(
          status: UploadProposalStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (success) {
        emit(state.copyWith(status: UploadProposalStatus.success));
      },
    );
  }
}
