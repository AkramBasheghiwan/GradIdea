import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:iconsax/iconsax.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

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
  final ProjectEntity? projects;

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
    if (!controller.formKey.currentState!.validate()) return;

    final cubit = context.read<UploadProjectCubit>();

    if (isEditing) {
      cubit.updateProject(
        id: widget.projects!.id!,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   ProjectUploadHeader(isEditing: isEditing),
            SizedBox(height: 20.h),

            /// Hero Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(22.w),
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withValues(alpha: 0.22),
                    blurRadius: 26,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 62.w,
                    height: 62.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.document_upload,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),

                  SizedBox(width: 14.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditing ? "تحديث مشروع التخرج" : "رفع مشروع التخرج",
                          style: AppTextStyle.bold(19, color: Colors.white),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          "شارك مشروعك الأكاديمي وأضف تفاصيله بشكل واضح ومنظم",
                          style: AppTextStyle.medium(
                            12,
                            color: Colors.white.withValues(alpha: .90),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// تفاصيل المشروع
            UploadSectionCard(
              title: "01 تفاصيل المشروع",
              icon: Iconsax.lamp_charge,
              children: [
                ProjectUploadBuildField(
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'اسم المشروع مطلوب';
                    }
                    return null;
                  },
                  controller: controller.nameController,
                  label: AppStrings.projectName,
                  hint: "اسم المشروع",
                  icon: Iconsax.text,
                ),

                SizedBox(height: 14.h),

                ProjectUploadBuildField(
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'وصف المشروع مطلوب';
                    }

                    if (v.trim().length < 10) {
                      return 'الوصف قصير جداً';
                    }

                    return null;
                  },
                  controller: controller.descController,
                  label: AppStrings.projectDesc,
                  hint: "اكتب وصف المشروع",
                  icon: Iconsax.document_text,
                  maxLines: 4,
                ),
              ],
            ),

            SizedBox(height: 18.h),

            /// التصنيف
            UploadSectionCard(
              title: "02 تصنيف المشروع",
              icon: Iconsax.category,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProjectUploadBuildSelectMajor(
                        onChanged: (val) {
                          setState(() {
                            controller.selectedDepartment = val;
                          });
                        },

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

            /// الفريق
            UploadSectionCard(
              title: "03 فريق العمل",
              icon: Iconsax.profile_2user,
              children: [
                ProjectUploadBuildField(
                  controller: controller.supervisorController,
                  label: "الدكتور المشرف",
                  hint: "اسم الدكتور المشرف",
                  icon: Iconsax.teacher,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'اسم الدكتور المشرف مطلوب';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 14.h),

                ProjectUploadBuildField(
                  controller: controller.studentsController,
                  label: "أعضاء الفريق",
                  hint: "اسم1, اسم2",
                  icon: Iconsax.people,
                  maxLines: 2,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'أسماء أعضاء الفريق مطلوبة';
                    }
                    return null;
                  },
                ),
              ],
            ),

            SizedBox(height: 18.h),

            /// المرفقات
            const UploadSectionCard(
              title: "04 المرفقات",
              icon: Iconsax.document_upload,
              children: [ProjectFileUploadArea()],
            ),

            SizedBox(height: 28.h),

            ProjectUploadBuildSubmitButtom(
              isLoading: widget.isLoading,
              onPressed: widget.isLoading ? null : submit,
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
