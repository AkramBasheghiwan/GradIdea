import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/utils/images_assests.dart';
import 'package:graduation_management_idea_system/core/utils/validator_manager.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/sign_upcubit.dart';
//import 'package:graduation_management_idea_system/feature/auth/presentation/manager/signUp_Cubit/sign_up_user_cubit.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/build_card_go_back_login.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class SignUpUserViewBody extends StatefulWidget {
  final bool isLoading;
  const SignUpUserViewBody({required this.isLoading, super.key});

  @override
  State<SignUpUserViewBody> createState() => _SignUpUserViewBodyState();
}

class _SignUpUserViewBodyState extends State<SignUpUserViewBody> {
  final TextEditingController nameUserController = TextEditingController();
  final TextEditingController emailUserController = TextEditingController();
  final TextEditingController passUserController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameUserController.dispose();
    emailUserController.dispose();
    passUserController.dispose();

    super.dispose();
  }

  String? selectedSpecialization;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              height: 350.h,
              AppImageAssets.backgroundGlow,
              fit: BoxFit.cover,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100.h),
                  Text(
                    AppStrings.createAccount,
                    style: AppTextStyle.wellComeText,
                  ),
                  Text(
                    AppStrings.joinUs,
                    style: AppTextStyle.subHeadline16NormalStyle.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  Container(
                    padding: EdgeInsets.all(AppDimens.p24.w),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppDimens.bottomContainerRadius.r),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          CustomAuthTextField(
                            controller: nameUserController,
                            label: AppStrings.nameLabel,
                            hintText: "الاسم الكامل",
                            prefixIcon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال الاسم الكامل';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomAuthTextField(
                            controller: emailUserController,
                            label: AppStrings.emailLabel,
                            hintText: AppString.emailHinte,
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              return ValidatorManager.validateEmail(value);
                            },
                          ),
                          SizedBox(height: 16.h),

                          // Dropdown للتخصص
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.majorLabel,
                                style: AppTextStyle.bodyLarge16NormalStyle
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.h),
                              DropdownButtonFormField(
                                value: selectedSpecialization,
                                decoration: InputDecoration(
                                  fillColor: AppColor.inputBackground,
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
                                hint: Text(
                                  "Select Major",
                                  style: AppTextStyle.bodyMedium,
                                ),
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem(
                                    value: 'IT',
                                    child: Text('IT'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CS',
                                    child: Text('CS'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'IS',
                                    child: Text('IS'),
                                  ),
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

                          SizedBox(height: 16.h),
                          CustomAuthTextField(
                            controller: passUserController,
                            label: AppStrings.passwordLabel,
                            hintText: AppString.hint,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                              color: AppColor.grey,
                            ),
                            validator: (value) {
                              return ValidatorManager.validatePassword(value);
                            },
                          ),

                          SizedBox(height: 32.h),

                          ElevatedButton(
                            onPressed: widget.isLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<SingUpCubit>().signUpUser(
                                        name: nameUserController.text,
                                        email: emailUserController.text,
                                        password: passUserController.text,
                                        specialization: selectedSpecialization!,
                                      );
                                    }
                                  },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              minimumSize: Size(double.infinity, 56.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: widget.isLoading
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    AppStrings.createAccount,
                                    style: AppTextStyle.mainButtonText,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().slideY(begin: 0.4, end: 0),

                  const BuildCardGoBackLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
