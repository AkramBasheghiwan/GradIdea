// project_upload_view_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/view_widget/project_header.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/view_widget/uploud_project_form_controller.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/view_widget/uploud_section_card.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/custom_build_select_year.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_field.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_file_area.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_select_major.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_submit_buttom.dart';

import '../../manager/upload_project_cubit/upload_project_cubit.dart';

class ProjectUploadViewBodys extends StatefulWidget {
  const ProjectUploadViewBodys({
    super.key,
    required this.isLoading,
    this.projects,
  });

  final bool isLoading;
  final dynamic projects;

  @override
  State<ProjectUploadViewBodys> createState() => _ProjectUploadViewBodyState();
}

class _ProjectUploadViewBodyState extends State<ProjectUploadViewBodys> {
  late final ProjectUploadFormController controller;

  bool get isEditing => widget.projects != null;

  @override
  void initState() {
    controller = ProjectUploadFormController(project: widget.projects);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit() {
    if (!controller.validate()) return;

    final cubit = context.read<UploadProjectCubit>();

    if (isEditing) {
      cubit.updateProject(
        id: widget.projects.id!,
        name: controller.nameController.text,
        description: controller.descController.text,
        department: controller.selectedDepartment ?? '',
        year: int.parse(controller.yearController.text),
        students: controller.studentsList,
        supervisor: controller.supervisorController.text,
      );
    } else {
      cubit.submitProject(
        name: controller.nameController.text,
        description: controller.descController.text,
        department: controller.selectedDepartment ?? '',
        year: int.parse(controller.yearController.text),
        students: controller.studentsList,
        supervisor: controller.supervisorController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            ProjectUploadHeader(isEditing: isEditing),

            SizedBox(height: 22.h),

            UploadSectionCard(
              title: "تفاصيل المشروع",
              icon: Icons.lightbulb_outline,
              children: [
                ProjectUploadBuildField(
                  validator: (v) => v!.isEmpty ? 'اسم المشروع مطلوب' : null,
                  controller: controller.nameController,
                  label: AppStrings.projectName,
                  hint: "اسم المشروع",
                  icon: Icons.title,
                ),
                SizedBox(height: 14.h),
                ProjectUploadBuildField(
                  validator: (v) => v!.length < 10 ? 'الوصف قصير جداً' : null,
                  controller: controller.descController,
                  label: AppStrings.projectDesc,
                  hint: "اكتب وصف المشروع",
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),
              ],
            ),

            SizedBox(height: 18.h),

            UploadSectionCard(
              title: "التصنيف",
              icon: Icons.category_outlined,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProjectUploadBuildSelectMajor(
                        onChanged: (val) =>
                            setState(() => controller.selectedDepartment = val),
                        selectedValue: controller.selectedDepartment,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProjectUploadBuildSelectYear(
                        selectedValue: controller.yearController.text.isEmpty
                            ? null
                            : controller.yearController.text,
                        onChanged: (String? value) {
                          setState(() {
                            controller.yearController.text = value ?? '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 18.h),

            UploadSectionCard(
              title: "الفريق",
              icon: Icons.groups_outlined,
              children: [
                ProjectUploadBuildField(
                  controller: controller.supervisorController,
                  label: "الدكتور المشرف",
                  hint: "اسم الدكتور",
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 14.h),
                ProjectUploadBuildField(
                  controller: controller.studentsController,
                  label: "أعضاء الفريق",
                  hint: "اسم1, اسم2",
                  icon: Icons.group_outlined,
                  maxLines: 2,
                ),
              ],
            ),

            SizedBox(height: 18.h),

            const UploadSectionCard(
              title: "المرفقات",
              icon: Icons.upload_file_outlined,
              children: [ProjectFileUploadArea()],
            ),

            SizedBox(height: 28.h),

            ProjectUploadBuildSubmitButtom(
              isLoading: widget.isLoading,
              onPressed: submit,
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
