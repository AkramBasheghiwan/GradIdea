import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';

import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_state.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/ai_suggestions_card.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/custom_buttom.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/similar_projects_section.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/validation_result_card.dart';
import 'package:iconsax/iconsax.dart';

class IdaeValidationViewBody extends StatefulWidget {
  const IdaeValidationViewBody({super.key});

  @override
  State<IdaeValidationViewBody> createState() => _IdaeValidationViewState();
}

class _IdaeValidationViewState extends State<IdaeValidationViewBody> {
  final TextEditingController ideaController = TextEditingController();

  @override
  void dispose() {
    ideaController.dispose();
    super.dispose();
  }

  void validateIdea() {
    context.read<IdeaValidationCubit>().validateIdea(ideaController.text);
  }

  void _generateAiSuggestions(List<SimilarProjectEntity> projects) {
    context.read<IdeaValidationCubit>().fetchAiSuggestions(
      idea: ideaController.text,
      similarProjectlist: projects,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: _buildAppBar(),
      body: BlocBuilder<IdeaValidationCubit, IdeaValidationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                _buildHeroSection(),

                SizedBox(height: 28.h),

                _buildInputCard(state),

                SizedBox(height: 18.h),

                _buildTipsCard(),

                SizedBox(height: 24.h),

                if (state is IdeaValidationLoading)
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: const CircularProgressIndicator(),
                  ),

                if (state is IdeaValidationError) ...[
                  _buildErrorCard(state.message),
                ],

                if (state is IdeaValidationSuccess) ...[
                  ValidationResultCard(result: state.result),

                  SizedBox(height: 20.h),

                  if (!state.result.isUnique)
                    AiSuggestionsCard(
                      isLoading: state.isAiLoading,
                      suggestions: state.aiSuggestions,
                      onGenerate: () =>
                          _generateAiSuggestions(state.result.similarProjects),
                    ),

                  SizedBox(height: 20.h),

                  SimilarProjectsSection(
                    projects: state.result.similarProjects,
                  ),
                ],

                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColor.background.withValues(alpha: 0.72),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(color: Colors.transparent),
        ),
      ),
      title: Text("المدقق الذكي", style: AppTextStyle.bold(18)),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        Container(
          width: 92.w,
          height: 92.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColor.primaryColor, AppColor.secondaryColor],
            ),
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: .25),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Icon(Iconsax.magicpen, color: Colors.white, size: 42.sp),
        ),

        SizedBox(height: 18.h),

        Text(
          AppStrings.heroTitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.extraBold(26),
        ),

        SizedBox(height: 10.h),

        Text(
          AppStrings.heroSubTitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.medium(14, color: AppColor.grey),
        ),
      ],
    );
  }

  Widget _buildInputCard(IdeaValidationState state) {
    final bool loading = state is IdeaValidationLoading;

    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: ideaController,
            maxLines: 6,
            style: AppTextStyle.medium(14),
            decoration: InputDecoration(
              hintText: AppStrings.inputPlaceholder,
              hintStyle: AppTextStyle.medium(
                14,
                color: AppColor.outlineVariant,
              ),
              filled: true,
              fillColor: AppColor.background,
              contentPadding: EdgeInsets.all(18.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: BorderSide(
                  color: AppColor.primaryColor.withValues(alpha: .25),
                ),
              ),
            ),
          ),

          SizedBox(height: 18.h),

          CustomButton(
            text: loading ? "جاري الفحص..." : AppStrings.checkButton,
            icon: Iconsax.search_normal,
            onPressed: loading
                ? null
                : () {
                    context.read<IdeaValidationCubit>().validateIdea(
                      ideaController.text,
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.lamp_charge,
                color: AppColor.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                "نصائح قبل الفحص",
                style: AppTextStyle.bold(15, color: AppColor.primaryColor),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          _tip("اشرح فكرة المشروع بوضوح"),
          _tip("اذكر التقنية المستخدمة"),
          _tip("وضح القيمة المضافة"),
          _tip("حدد المجال أو القسم"),
        ],
      ),
    );
  }

  Widget _tip(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(Iconsax.tick_circle, size: 18.sp, color: AppColor.primaryColor),
          SizedBox(width: 8.w),
          Expanded(child: Text(text, style: AppTextStyle.medium(13))),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(Iconsax.warning_2, color: Colors.red, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: AppTextStyle.medium(13, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
