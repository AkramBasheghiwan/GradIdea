import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';
// import 'package:dartz/dartz.dart';

class UploadProjectCubit extends Cubit<UploadProjectState> {
  UploudProjectRepository repository;
  UploadProjectCubit({required this.repository}) : super(UploadProjectState());

  // ==========================================
  // 1. دوال التعامل مع الملفات
  // ==========================================

  Future<void> pickProjectFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'zip'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String name = result.files.single.name;

        // تحديث الحالة بالملف الجديد
        emit(state.copyWith(selectedFile: file, fileName: name));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UploadProjectStatus.error,
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

  Future<void> submitProject({
    required String name,
    required String description,
    required String department,
    required int year,
    required List<String> students,
    required String supervisor,
  }) async {
    emit(state.copyWith(status: UploadProjectStatus.loading));

    if (state.selectedFile == null) {
      emit(
        state.copyWith(
          status: UploadProjectStatus.error,
          errorMessage: "يرجى إرفاق ملف المشروع أولاً.",
        ),
      );
      return;
    }

    final result = await repository.uploadProjectToArchive(
      ProjectEntity(
        name: name,
        description: description,
        department: department,
        year: year,
        students: students,
        supervisor: supervisor,
        projectFile: state.selectedFile, // نمرر الملف للـ UseCase
      ),
    );

    // التعامل مع النتيجة باستخدام fold من Dartz
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UploadProjectStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (success) {
        emit(state.copyWith(status: UploadProjectStatus.success));
        clearSelectedFile(); // تفريغ الملف بعد النجاح
      },
    );

    // ==========================================
    // 3. دالة تعديل مشروع حالي
    // ==========================================
  }

  Future<void> updateProject({
    required String id,
    required String name,
    required String description,
    required String department,
    required int year,
    required List<String> students,
    required String supervisor,
  }) async {
    emit(state.copyWith(status: UploadProjectStatus.loading));

    final result = await repository.updateProject(
      ProjectEntity(
        id: id,
        name: name,
        description: description,
        department: department,
        year: year,
        students: students,
        supervisor: supervisor,
        projectFile: state.selectedFile, // قد يكون null وهذا طبيعي في التعديل
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UploadProjectStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (success) {
        emit(state.copyWith(status: UploadProjectStatus.success));
        clearSelectedFile();
      },
    );
  }
}
