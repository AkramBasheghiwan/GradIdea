import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/profiel_form_controller.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/acadimaic_form.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edit_profile_header.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edite_avatar_card.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/edite_profile_stepper.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/gradient_button.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/persional_form.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/widgets/review_card.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({
    super.key,
    required this.currentStep,
    required this.controllers,
    required this.personalForm,
    required this.academicForm,
    this.onBack,
    this.onNext,
    this.onSubmit,
    this.onPickImage,
  });

  final int currentStep;
  final GlobalKey<FormState> personalForm;
  final GlobalKey<FormState> academicForm;
  final EditProfileControllers controllers;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final VoidCallback? onSubmit;
  final VoidCallback? onPickImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            children: [
              EditProfileHeader(onBack: onBack, onNext: onNext),

              SizedBox(height: 26.h),

              EditProfileStepper(currentStep: currentStep),

              SizedBox(height: 26.h),

              if (currentStep == 0) ...[
                GestureDetector(
                  onTap: onPickImage,
                  child: const EditAvatarCard(),
                ),

                SizedBox(height: 24.h),

                Form(
                  key: personalForm,
                  child: PersonalForm(controllers: controllers),
                ),
              ],

              if (currentStep == 1) ...[
                Form(
                  key: academicForm,
                  child: AcademicForm(controllers: controllers),
                ),
              ],

              if (currentStep == 2) ...[const ReviewCard()],

              SizedBox(height: 28.h),

              GradientButton(
                title: currentStep == 2 ? "حفظ التعديلات" : "التالي",
                onTap: currentStep == 2 ? onSubmit : onNext,
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
