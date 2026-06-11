import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profiel_form_controller.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/edite_avatar_card.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/gradient_button.dart';

import 'package:graduation_management_idea_system/feature/profile/presentation/views/widgets/persional_form.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({
    super.key,
    required this.controllers,
    required this.isLoading,
    required this.personalForm,
    this.onSubmit,
  });
  final bool isLoading;
  final GlobalKey<FormState> personalForm;

  final VoidCallback? onSubmit;

  final EditProfileControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              SizedBox(height: 26.h),

              const EditAvatarCard(),

              SizedBox(height: 24.h),

              Form(
                key: personalForm,
                child: PersonalForm(controllers: controllers),
              ),

              SizedBox(height: 28.h),

              GradientButton(
                title: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'حفظ التعديلات',
                        style: AppTextStyle.bold(15, color: Colors.white),
                      ),
                onTap: isLoading
                    ? null
                    : () {
                        if (personalForm.currentState!.validate()) {
                          onSubmit?.call();
                        }
                      },
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
