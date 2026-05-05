import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBuildSelectMajor extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? selectedValue;

  const ProjectUploadBuildSelectMajor({
    required this.onChanged,
    required this.selectedValue,
    super.key,
  });

  static const List<String> _departments = ['IT', 'CS', 'IS'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر التخصص',
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          // 🟢 هذه الخاصية هي مفتاح الحل لمنع الـ Overflow الداخلي
          isExpanded: true,
          borderRadius: BorderRadius.circular(16.r),
          elevation: 2,
          value: selectedValue,
          dropdownColor: Colors.white,
          // تحسين مظهر النص المختار
          style: AppTextStyle.bodyMedium.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.school_outlined,
              color: AppColor.secondaryColor,
              size: 20,
            ),
            fillColor: AppColor.inputBackground.withValues(alpha: 0.5),
            filled: true,
            hintText: "التخصص",
            hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
          items: _departments.map((String dept) {
            return DropdownMenuItem<String>(value: dept, child: Text(dept));
          }).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'مطلوب' : null,
        ),
      ],
    );
  }
}
