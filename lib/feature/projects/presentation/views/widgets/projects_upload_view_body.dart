import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_area.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_field.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_form.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_select_major.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_submit_buttom.dart';

class ProjectUploadViewBody extends StatefulWidget {
  final bool isLoading;
  final ProjectEntity?
  projects; // إذا كان null يعني إضافة، وإذا كان يحمل بيانات يعني تعديل

  const ProjectUploadViewBody({
    required this.isLoading,
    this.projects,
    super.key,
  });

  @override
  State<ProjectUploadViewBody> createState() => _ProjectUploadViewBodyState();
}

class _ProjectUploadViewBodyState extends State<ProjectUploadViewBody> {
  // 1. تعريف مفتاح الفورم للتحقق (Validation)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _studentsController = TextEditingController();
  final TextEditingController _supervisorController = TextEditingController();

  String? _selectedDept;

  bool get isEditing => widget.projects != null;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    if (isEditing) {
      _nameController.text = widget.projects!.name;
      _descController.text = widget.projects!.description;
      _deptController.text = widget.projects!.department;
      _selectedDept = widget.projects!.department;
      _yearController.text = widget.projects!.year
          .toString(); // افتراض أن السنة رقم أو نص

      // افتراض أن الطلاب مصفوفة (List)، نقوم بتحويلها لنص مفصول بفواصل لعرضه في الحقل
      _studentsController.text = widget.projects!.students.join(', ');

      _supervisorController.text = widget.projects!.supervisor;
    }
  }

  @override
  void dispose() {
    // لا تقم باستدعاء دالة التهيئة هنا أبداً
    _nameController.dispose();
    _descController.dispose();
    _deptController.dispose();
    _yearController.dispose();
    _studentsController.dispose();
    _supervisorController.dispose();
    super.dispose();
  }

  void _submitProject() {
    if (_formKey.currentState!.validate()) {
      final studentsList = _studentsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (isEditing) {
        context.read<UploadProjectCubit>().updateProject(
          id: widget.projects!.id!,
          name: _nameController.text,
          description: _descController.text,
          department: _deptController.text,
          year: int.tryParse(_yearController.text) ?? DateTime.now().year,
          students: studentsList,
          supervisor: _supervisorController.text,
        );
        log("تم التحقق بنجاح! جاهز لتعديل المشروع.");
      } else {
        context.read<UploadProjectCubit>().submitProject(
          name: _nameController.text,
          description: _descController.text,
          department: _deptController.text,
          year: int.tryParse(_yearController.text) ?? DateTime.now().year,
          students: studentsList,
          supervisor: _supervisorController.text,
        );
        log("تم التحقق بنجاح! جاهز لإرسال مشروع جديد.");
      }
    } else {
      log("يرجى ملء جميع الحقول المطلوبة.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? "تعديل بيانات المشروع" : AppStrings.uploadSubTitle,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.h),

            // 1. قسم معلومات المشروع
            ProjectUploadBuildForm(
              title: "معلومات المشروع",
              icon: Icons.assignment_outlined,
              children: [
                ProjectUploadBuildField(
                  controller: _nameController,
                  label: AppStrings.projectName,
                  hint: "مثلاً: نظام إدارة ذكي",
                  icon: Icons.title,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال اسم المشروع';
                    }
                    if (value.length < 5) {
                      return 'اسم المشروع يجب أن يكون 5 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                ProjectUploadBuildField(
                  controller: _descController,
                  label: AppStrings.projectDesc,
                  hint: "اكتب وصفاً مختصراً للمشروع...",
                  icon: Icons.description,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى كتابة وصف للمشروع';
                    }
                    if (value.length < 20) {
                      return 'الوصف قصير جداً، يرجى التفصيل أكثر (20 حرفاً على الأقل)';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: ProjectUploadBuildSelectMajor(
                        onChanged: (String? value) {
                          setState(() {
                            _selectedDept = value;
                            _deptController.text = value ?? '';
                          });
                        },
                        selectedValue: _selectedDept,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: ProjectUploadBuildField(
                        controller: _yearController,
                        label: "السنة",
                        hint: "2026-2025", // يمكنك جعله ديناميكي أيضاً
                        icon: Icons.calendar_today_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'مطلوب';
                          if (int.tryParse(value) == null) return 'أرقام فقط';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // 2. قسم فريق العمل (Team Info)
            ProjectUploadBuildForm(
              title: "فريق العمل والمشرف",
              icon: Icons.groups_outlined,
              children: [
                ProjectUploadBuildField(
                  controller: _studentsController,
                  label: AppStrings.studentsNames,
                  hint: "أدخل الأسماء مفصولة بفاصلة (,)",
                  icon: Icons.people_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال أسماء الطلاب';
                    }
                    return null;
                  },
                ),
                ProjectUploadBuildField(
                  controller: _supervisorController,
                  label: AppStrings.supervisorName,
                  hint: "اسم الدكتور المشرف",
                  icon: Icons.person_outline,
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال اسم المشرف' : null,
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // 3. منطقة رفع الملفات (File Upload Area)
            const ProjectFileUploadArea(),
            SizedBox(height: 40.h),

            // 4. زر الإرسال الرئيسي (Submit Button)
            ProjectUploadBuildSubmitButtom(
              isLoading: widget.isLoading,
              onPressed: _submitProject,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
