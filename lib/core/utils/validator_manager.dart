import 'package:graduation_management_idea_system/core/utils/app_strings.dart';

class ValidatorManager {
  static const int _minPasswordLength = 8; // المعيار العالمي هو 8 وليس 6

  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp _passwordComplexityRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
  );

  static String? validateEmail(String? value) {
    final String val = value?.trim() ?? "";

    if (val.isEmpty) {
      return AppString.requiredField;
    }

    if (!_emailRegex.hasMatch(val)) {
      return AppString.invalidEmail;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    final String val = value ?? "";

    if (val.isEmpty) {
      return AppString.requiredField;
    }

    if (val.length < _minPasswordLength) {
      return AppString.passwordShort;
    }

    if (!_passwordComplexityRegex.hasMatch(val)) {
      return AppString.passwordWeak;
    }

    return null;
  }

  static String? validateName(String? value) {
    final String? val = value;
    if (val == null || val.trim().isEmpty) {
      return "";
    }
    return null;
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return "";
    } else if (val.length < 9) {
      return "";
    }
    return null;
  }
}
