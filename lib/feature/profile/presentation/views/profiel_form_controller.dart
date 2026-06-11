import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

class EditProfileControllers {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final specialization = TextEditingController();

  final major = TextEditingController();
  final college = TextEditingController();
  final level = TextEditingController();
  final interests = TextEditingController();

  void showStudentInf(UserEntity user) {
    name.text = user.name;
    phone.text = user.phone ?? '';
    specialization.text = user.specialization!;
  }

  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    specialization.dispose();
    major.dispose();
    college.dispose();
    level.dispose();
    interests.dispose();
  }
}
