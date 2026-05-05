import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class ProjectUploadBuildSelectYear extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const ProjectUploadBuildSelectYear({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  List<String> _generateYears() {
    List<String> years = [];
    for (int i = 2015; i <= 2060; i++) {
      years.add("$i-${i + 1}");
    }
    return years;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سنة التخرج',
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedValue,
          borderRadius: BorderRadius.circular(16.r),
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.calendar_today_outlined,
              color: AppColor.secondaryColor,
              size: 20,
            ),
            fillColor: AppColor.inputBackground.withValues(alpha: 0.5),
            filled: true,
            hintText: "اختر السنة",
            hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
          ),
          items: _generateYears().map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(
                year,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'مطلوب' : null,
        ),
      ],
    );
  }
}
