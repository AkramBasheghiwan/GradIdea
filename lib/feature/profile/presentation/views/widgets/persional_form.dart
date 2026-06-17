import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profiel_form_controller.dart';

import 'package:iconsax/iconsax.dart';

import 'profile_text_field.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({super.key, required this.controllers});

  final EditProfileControllers controllers;

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  String? selectedSpecialization;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextField(
          controller: widget.controllers.name,
          label: "الاسم الكامل",
          hint: "أدخل اسمك الكامل",
          icon: Iconsax.user,
        ),

        SizedBox(height: 18.h),

        ProfileTextField(
          controller: widget.controllers.phone,
          label: "رقم الهاتف",
          hint: "05xxxxxxxx",
          icon: Iconsax.call,
          keyboardType: TextInputType.phone,
        ),

        SizedBox(height: 18.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.majorLabel,
              style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField(
              value: selectedSpecialization,
              decoration: InputDecoration(
                fillColor: AppColor.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.primaryColor,
                ),
              ),
              hint: Text("Select Major", style: AppTextStyle.bodyMedium),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(value: 'IT', child: Text('IT')),
                DropdownMenuItem(value: 'CS', child: Text('CS')),
                DropdownMenuItem(value: 'IS', child: Text('IS')),
              ], // أضف قائمة التخصصات هنا
              onChanged: (String? newValue) {
                setState(() {
                  selectedSpecialization = newValue;
                });
              },
              validator: (String? value) {
                if (value == null) {
                  return 'يرجى اختيار التخصص';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
