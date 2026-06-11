import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profiel_form_controller.dart';

import 'package:iconsax/iconsax.dart';

import 'profile_text_field.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({super.key, required this.controllers});

  final EditProfileControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextField(
          controller: controllers.name,
          label: "الاسم الكامل",
          hint: "أدخل اسمك الكامل",
          icon: Iconsax.user,
        ),

        SizedBox(height: 18.h),

        ProfileTextField(
          controller: controllers.phone,
          label: "رقم الهاتف",
          hint: "05xxxxxxxx",
          icon: Iconsax.call,
          keyboardType: TextInputType.phone,
        ),

        SizedBox(height: 18.h),
        ProfileTextField(
          controller: controllers.major,
          label: "التخصص",
          hint: 'IT',
          icon: Iconsax.teacher,
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
