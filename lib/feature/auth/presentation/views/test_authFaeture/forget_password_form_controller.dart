import 'package:flutter/cupertino.dart';

class ForgetPasswordFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailForgetController = TextEditingController();

  get validate => formKey.currentState!.validate();

  void close() {
    emailForgetController.dispose();
  }
}
