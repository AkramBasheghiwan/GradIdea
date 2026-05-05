import 'package:flutter/material.dart';

class EditProfileControllers {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final bio = TextEditingController();

  final major = TextEditingController();
  final college = TextEditingController();
  final level = TextEditingController();
  final interests = TextEditingController();

  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    bio.dispose();
    major.dispose();
    college.dispose();
    level.dispose();
    interests.dispose();
  }
}
