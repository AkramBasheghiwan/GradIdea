// project_upload_form_controller.dart

import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

class ProjectUploadFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final yearController = TextEditingController();
  final studentsController = TextEditingController();
  final supervisorController = TextEditingController();

  String? selectedDepartment;

  ProjectUploadFormController({ProjectEntity? project}) {
    if (project != null) {
      nameController.text = project.name;
      descController.text = project.description;
      yearController.text = project.year.toString();
      studentsController.text = project.students.join(', ');
      supervisorController.text = project.supervisor;
      selectedDepartment = project.department;
    }
  }

  List<String> get studentsList => studentsController.text
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    nameController.dispose();
    descController.dispose();
    yearController.dispose();
    studentsController.dispose();
    supervisorController.dispose();
  }

  void clear() {
    nameController.clear();
    descController.clear();
    yearController.clear();
    studentsController.clear();
    supervisorController.clear();
  }
}
