import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/custom_build_select_year.dart';
import 'package:iconsax/iconsax.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_field.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_select_major.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/views/widgets/project_upload_build_submit_buttom.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/helper/build_show_supervisor_uttom_sheet.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/uploud_proposal_views/widgets/build_proposal_file_area.dart';

class UploudProposalViewBody extends StatefulWidget {
  final bool isLoading;
  final ProjectProposals? projects;

  const UploudProposalViewBody({
    super.key,
    required this.isLoading,
    this.projects,
  });

  @override
  State<UploudProposalViewBody> createState() => _UploudProposalViewBodyState();
}

class _UploudProposalViewBodyState extends State<UploudProposalViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _yearController;
  late final TextEditingController _studentsController;
  late final TextEditingController _supervisorController;

  String? _selectedDept;
  String? _selectedSupervisorId;

  bool get isEditing => widget.projects != null;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.projects?.name);

    _descController = TextEditingController(text: widget.projects?.description);

    _yearController = TextEditingController(
      text: widget.projects?.year.toString() ?? '',
    );

    _studentsController = TextEditingController(
      text: widget.projects?.students.join(', ') ?? '',
    );

    _supervisorController = TextEditingController(
      text: widget.projects?.supervisor ?? '',
    );

    _selectedDept = widget.projects?.department;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _yearController.dispose();
    _studentsController.dispose();
    _supervisorController.dispose();
    super.dispose();
  }

  void _pickSupervisor() async {
    final supervisor = await showSupervisorBottomSheet(context);

    if (supervisor != null) {
      setState(() {
        _selectedSupervisorId = supervisor['id'];
        _supervisorController.text = supervisor['name']!;
      });
    }
  }

  void _submitProposal() {
    if (!_formKey.currentState!.validate()) return;

    final studentsList = _studentsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (studentsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل عضو فريق واحد على الأقل')),
      );
      return;
    }

    final cubit = context.read<UploadProposalCubit>();

    if (isEditing) {
      cubit.updateProposal(
        id: widget.projects!.id!,
        supervisorId: _selectedSupervisorId!,
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        department: _selectedDept ?? '',
        year: int.tryParse(_yearController.text) ?? DateTime.now().year,
        students: studentsList,
        supervisor: _supervisorController.text.trim(),
      );
    } else {
      cubit.submitProposal(
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        department: _selectedDept ?? '',
        year: int.tryParse(_yearController.text) ?? DateTime.now().year,
        students: studentsList,
        supervisor: _supervisorController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHero(),
                SizedBox(height: 24.h),

                _buildProjectDetailsSection(),
                SizedBox(height: 18.h),

                _buildClassificationSection(),
                SizedBox(height: 18.h),

                _buildTeamSection(),
                SizedBox(height: 18.h),

                _buildFilesSection(),
                SizedBox(height: 28.h),

                ProjectUploadBuildSubmitButtom(
                  isLoading: widget.isLoading,
                  onPressed: widget.isLoading ? null : _submitProposal,
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .22),
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
                  isEditing ? "تحديث مقترح المشروع" : "رفع مقترح مشروع",
                  style: AppTextStyle.bold(19, color: Colors.white),
                ),

                SizedBox(height: 8.h),

                Text(
                  "قدّم فكرتك الأكاديمية بشكل منظم وواضح لبدء رحلة الاعتماد",
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
    );
  }

  Widget _buildProjectDetailsSection() {
    return _buildSectionContainer(
      title: "01 تفاصيل المشروع",
      icon: Iconsax.lamp_charge,
      children: [
        ProjectUploadBuildField(
          controller: _nameController,
          label: AppStrings.projectName,
          hint: "مثلاً: منصة ذكية لإدارة مشاريع التخرج",
          icon: Iconsax.text,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'اسم المشروع مطلوب';
            }
            return null;
          },
        ),

        SizedBox(height: 14.h),

        ProjectUploadBuildField(
          controller: _descController,
          label: AppStrings.projectDesc,
          hint: "اكتب وصفاً واضحاً لفكرة المشروع",
          icon: Iconsax.document_text,
          maxLines: 4,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'وصف المشروع مطلوب';
            }

            if (v.trim().length < 10) {
              return 'الوصف قصير جداً';
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget _buildClassificationSection() {
    return _buildSectionContainer(
      title: "02 تصنيف المشروع",
      icon: Iconsax.category,
      children: [
        Row(
          children: [
            Expanded(
              child: ProjectUploadBuildSelectMajor(
                selectedValue: _selectedDept,
                onChanged: (val) {
                  setState(() {
                    _selectedDept = val;
                  });
                },
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: ProjectUploadBuildSelectYear(
                selectedValue: _yearController.text.isEmpty
                    ? null
                    : _yearController.text,
                onChanged: (String? value) {
                  setState(() {
                    _yearController.text = value ?? '';
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return _buildSectionContainer(
      title: "03 فريق العمل",
      icon: Iconsax.profile_2user,
      children: [
        GestureDetector(
          onTap: _pickSupervisor,
          child: AbsorbPointer(
            child: ProjectUploadBuildField(
              controller: _supervisorController,
              label: "الدكتور المشرف",
              hint: "اختر المشرف",
              icon: Iconsax.teacher,
              validator: (_) {
                if (_supervisorController.text.trim().isEmpty) {
                  return 'يرجى اختيار المشرف';
                }
                return null;
              },
            ),
          ),
        ),

        SizedBox(height: 14.h),

        ProjectUploadBuildField(
          controller: _studentsController,
          label: "أعضاء الفريق",
          hint: "محمد, أحمد, علي",
          icon: Iconsax.people,
          maxLines: 2,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'أسماء الفريق مطلوبة';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFilesSection() {
    return _buildSectionContainer(
      title: "04 المرفقات",
      icon: Iconsax.document_upload,
      children: const [BuildProposalFileArea()],
    );
  }

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
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: AppColor.primaryColor, size: 20.sp),

              SizedBox(width: 8.w),

              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              thickness: 1,
              color: Colors.grey.withValues(alpha: .10),
            ),
          ),

          ...children,
        ],
      ),
    );
  }
}
