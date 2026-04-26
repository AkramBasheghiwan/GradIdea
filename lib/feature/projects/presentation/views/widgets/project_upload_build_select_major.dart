import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectUploadBuildSelectMajor extends StatelessWidget {
  final ValueChanged<String?>? onChanged;

  final String? selectedValue;

  // 2. استخدمنا const Constructor لتحسين الأداء
  const ProjectUploadBuildSelectMajor({
    required this.onChanged,
    required this.selectedValue, // نطلبه هنا
    super.key,
  });

  // 3. جعلنا القائمة ثابتة (static const) لعدم استهلاك الذاكرة في كل Rebuil
  static const List<String> _departments = ['IT', 'CS', 'IS'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment
                .start, // تحسين المظهر ليكون النص على اليمين/اليسار
            children: [
              Text(
                'اختر التخصص',
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ), // استخدمنا .r للـ radius
                  elevation: 2,
                  alignment: Alignment.topCenter,
                  // 4. نمرر القيمة التي جاءت من الأب هنا لكي يتم عرضها
                  value: selectedValue,
                  dropdownColor: AppColor.background,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      // إضافة const هنا
                      Icons.school_outlined,
                      color: AppColor.secondaryColor,
                      size: 20,
                    ),
                    hintStyle: TextStyle(
                      color: AppColor.textSecondary.withValues(alpha: 0.4),
                      fontSize: 13.sp,
                    ),
                    fillColor: AppColor.inputBackground.withValues(alpha: 0.5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                        "اختر القسم", // من الأفضل وضع نص تلميحي بدلاً من تركه فارغاً
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  items: _departments.map((String dept) {
                    return DropdownMenuItem<String>(
                      value: dept,
                      child: Text(
                        dept,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
