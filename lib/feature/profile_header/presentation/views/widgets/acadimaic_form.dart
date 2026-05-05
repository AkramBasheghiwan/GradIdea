import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/profiel_form_controller.dart';

import 'profile_text_field.dart';

class AcademicForm extends StatelessWidget {
  const AcademicForm({super.key, required this.controllers});

  final EditProfileControllers controllers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextField(
          controller: controllers.major,
          label: "التخصص",
          hint: "علوم الحاسب",
          icon: Iconsax.teacher,
        ),

        SizedBox(height: 18.h),

        ProfileTextField(
          controller: controllers.college,
          label: "الكلية",
          hint: "كلية الحاسبات وتقنية المعلومات",
          icon: Iconsax.building,
        ),

        SizedBox(height: 18.h),

        ProfileTextField(
          controller: controllers.level,
          label: "المستوى الدراسي",
          hint: "المستوى الثامن",
          icon: Iconsax.book,
        ),

        SizedBox(height: 18.h),

        ProfileTextField(
          controller: controllers.interests,
          label: "الاهتمامات البحثية",
          hint: "ذكاء اصطناعي، أمن سيبراني...",
          icon: Iconsax.lamp_charge,
          maxLines: 3,
        ),
      ],
    );
  }
}
