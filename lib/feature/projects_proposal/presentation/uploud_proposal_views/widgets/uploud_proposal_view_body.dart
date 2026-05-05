import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/helper/build_show_supervisor_uttom_sheet.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/widgets/build_proposal_file_area.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_field.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_select_major.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_submit_buttom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploudProposalViewBody extends StatefulWidget {
  final bool isLoading;
  final ProjectProposals? projects;

  const UploudProposalViewBody({
    required this.isLoading,
    this.projects,
    super.key,
  });

  @override
  State<UploudProposalViewBody> createState() => _UploudProposalViewBodyState();
}

class _UploudProposalViewBodyState extends State<UploudProposalViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _yearController;
  late final TextEditingController _studentsController;

  String? _selectedDept;
  String? _selectedSupervisorName;
  String? _selectedSupervisorId;
  bool get isEditing => widget.projects != null;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.projects?.name);
    _descController = TextEditingController(text: widget.projects?.description);
    _yearController = TextEditingController(
      text: widget.projects?.year.toString(),
    );
    _studentsController = TextEditingController(
      text: widget.projects?.students.join(', '),
    );
    //_selectedSupervisorId = widget.projects?.supervisorId;
    _selectedSupervisorName = widget.projects?.supervisor;

    _selectedDept = widget.projects?.department;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _yearController.dispose();
    _studentsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(
          context,
        ).unfocus(), // إغلاق الكيبورد عند الضغط خارج الحقول
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 25.h),

                // 1. قسم تفاصيل المشروع
                _buildSectionContainer(
                  title: "تفاصيل المشروع",
                  icon: Icons.lightbulb_outline,
                  children: [
                    ProjectUploadBuildField(
                      controller: _nameController,
                      label: AppStrings.projectName,
                      hint: "مثلاً: نظام إدارة ذكي",
                      icon: Icons.title,
                      validator: (v) => v!.isEmpty ? 'اسم المشروع مطلوب' : null,
                    ),
                    SizedBox(height: 15.h),
                    ProjectUploadBuildField(
                      controller: _descController,
                      label: AppStrings.projectDesc,
                      hint: "اكتب وصفاً مختصراً للمشروع...",
                      icon: Icons.description_outlined,
                      maxLines: 4,
                      validator: (v) =>
                          v!.length < 10 ? 'الوصف قصير جداً' : null,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // 2. قسم التصنيف (تخصص وسنة)
                _buildSectionContainer(
                  title: "التصنيف الزمني والأكاديمي",
                  icon: Icons.category_outlined,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProjectUploadBuildSelectMajor(
                            onChanged: (val) =>
                                setState(() => _selectedDept = val),
                            selectedValue: _selectedDept,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ProjectUploadBuildField(
                            controller: _yearController,
                            label: "السنة الدراسية",
                            hint: "2025",
                            icon: Icons.event,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // 3. قسم الفريق
                _buildSectionContainer(
                  title: "فريق العمل",
                  icon: Icons.groups_outlined,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final supervisor = await showSupervisorBottomSheet(
                          context,
                        );

                        if (supervisor != null) {
                          setState(() {
                            _selectedSupervisorId = supervisor['id'];
                            _selectedSupervisorName = supervisor['name'];
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: ProjectUploadBuildField(
                          controller: TextEditingController(
                            text: _selectedSupervisorName ?? '',
                          ),
                          label: "الدكتور المشرف",
                          hint: "اختر المشرف",
                          icon: Icons.person_search_outlined,
                          validator: (_) {
                            if (_selectedSupervisorId == null) {
                              return 'يرجى اختيار المشرف';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // ProjectUploadBuildField(
                    //   controller: _supervisorController,
                    //   label: "الدكتور المشرف",
                    //   hint: "اسم الدكتور المشرف",
                    //   icon: Icons.person_search_outlined,
                    // ),
                    SizedBox(height: 15.h),
                    ProjectUploadBuildField(
                      controller: _studentsController,
                      label: "أعضاء الفريق",
                      hint: "الأسماء (افصل بينهم بفاصلة ,)",
                      icon: Icons.group_add_outlined,
                      maxLines: 2,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // 4. المرفقات
                _buildSectionContainer(
                  title: "المرفقات والملفات",
                  icon: Icons.cloud_upload_outlined,
                  children: [const BuildProposalFileArea()],
                ),

                SizedBox(height: 35.h),

                // 5. زر الإرسال
                ProjectUploadBuildSubmitButtom(
                  isLoading: widget.isLoading,
                  onPressed: _submitProposal,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- دالة بناء الهيدر ---
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEditing ? "تحديث المشروع" : "مقترح جديد",
          style: AppTextStyle.titleLarge18NormalStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          isEditing
              ? "قم بتعديل البيانات المطلوبة أدناه"
              : AppStrings.uploadSubTitle,
          style: AppTextStyle.bodyMedium.copyWith(
            color: Colors.grey.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  // --- دالة بناء القسم (Container الأنيق) ---
  Widget _buildSectionContainer({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: AppColor.primaryColor),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.1),
              thickness: 1,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _submitProposal() {
    if (_formKey.currentState!.validate()) {
      final studentsList = _studentsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (isEditing) {
        context.read<UploadProposalCubit>().updateProposal(
          id: widget.projects!.id!,
          name: _nameController.text,
          description: _descController.text,
          department: _selectedDept ?? '',
          year: int.tryParse(_yearController.text) ?? DateTime.now().year,
          students: studentsList,
          supervisor: _selectedSupervisorName ?? '',
        );
      } else {
        context.read<UploadProposalCubit>().submitProposal(
          name: _nameController.text,
          description: _descController.text,
          department: _selectedDept ?? '',
          year: int.tryParse(_yearController.text) ?? DateTime.now().year,
          students: studentsList,
          supervisor: _selectedSupervisorName ?? '',
        );
      }
    }
  }
}
