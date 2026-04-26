import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_animate/flutter_animate.dart';

class IdeaValidationScreen extends StatefulWidget {
  const IdeaValidationScreen({super.key});

  @override
  State<IdeaValidationScreen> createState() => _IdeaValidationScreenState();
}

class _IdeaValidationScreenState extends State<IdeaValidationScreen> {
  final TextEditingController _ideaController = TextEditingController();

  @override
  void dispose() {
    _ideaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColor.background, // لون خلفية مريح للعين (Apple Style)
      appBar: AppBar(
        title: Text(
          'فحص أصالة الفكرة',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<IdeaValidationCubit, IdeaValidationState>(
        listener: (context, state) {
          if (state is IdeaValidationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is IdeaValidationLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'أدخل تفاصيل مشروع التخرج لنقوم بفحصه عبر قاعدة بيانات المشاريع السابقة لضمان تفرده.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 400.ms),

                SizedBox(height: 32.h),

                // حقل إدخال الفكرة بتصميم عصري
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _ideaController,
                    maxLines: 5,
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      hintText:
                          'مثلاً: منصة لإدارة المشاريع الجامعية باستخدام Flutter...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16.w),
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 400.ms).fadeIn(),

                SizedBox(height: 24.h),

                // زر الفحص
                SizedBox(
                      height: 54.h,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                context
                                    .read<IdeaValidationCubit>()
                                    .validateIdea(_ideaController.text);
                                FocusScope.of(
                                  context,
                                ).unfocus(); // إخفاء الكيبورد
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Apple style button
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'تحليل الفكرة',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    )
                    .animate()
                    .slideY(begin: 0.2, delay: 100.ms, duration: 400.ms)
                    .fadeIn(),

                SizedBox(height: 40.h),

                // استخدام Skeletonizer أثناء التحميل الأساسي

                // عرض النتيجة
                if (state is IdeaValidationSuccess)
                  _buildResultSection(
                    context,
                    state,
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
              ],
            ),
          );
        },
      ),
    );
  }

  // ودجت وهمي ليقوم الـ Skeletonizer بتغطيته وإنشاء شكل التحميل
  Widget _buildDummyResultForSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        SizedBox(height: 24.h),
        Container(height: 20.h, width: 150.w, color: Colors.grey.shade300),
        SizedBox(height: 16.h),
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection(
    BuildContext context,
    IdeaValidationSuccess state,
  ) {
    final isUnique = state.result.isUnique;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // حالة الفكرة (بطاقة أنيقة)
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isUnique ? const Color(0xFFF2FBF5) : const Color(0xFFFFF9F0),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isUnique
                  ? const Color(0xFFD4F3E0)
                  : const Color(0xFFFFECCC),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isUnique
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isUnique ? Icons.check_rounded : Icons.warning_rounded,
                  color: isUnique
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isUnique ? 'فكرة أصيلة!' : 'توجد مشاريع مشابهة',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: isUnique
                            ? Colors.green.shade900
                            : Colors.orange.shade900,
                      ),
                    ),
                    Text(
                      isUnique
                          ? 'يبدو أن هذه الفكرة جديدة، يمكنك البدء.'
                          : 'ننصحك بالاطلاع على المشاريع أدناه.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isUnique
                            ? Colors.green.shade800
                            : Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (!isUnique) ...[
          SizedBox(height: 32.h),
          Text(
            'المشاريع المشابهة',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
          ),
          SizedBox(height: 16.h),

          // قائمة المشاريع المشابهة
          ...((state.result.similarProjects ?? []).map(
            (project) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          project.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '%${project.similarityPercentage.toInt()}',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().slideX(begin: 0.1, duration: 300.ms).fadeIn(),
          )),

          SizedBox(height: 32.h),

          // قسم اقتراحات الذكاء الاصطناعي (مخفية حتى يتم طلبها)
          if (state.aiSuggestions == null)
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton.icon(
                onPressed: state.isAiLoading
                    ? null
                    : () => context
                          .read<IdeaValidationCubit>()
                          .fetchAiSuggestions(
                            idea: _ideaController.text,
                            similarProjectlist: state.result.similarProjects,
                          ),
                icon: state.isAiLoading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.blueAccent,
                      ),
                label: Text(
                  state.isAiLoading
                      ? 'جاري تحليل الفكرة...'
                      : 'طلب اقتراحات AI للتميز',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            )
          else
            Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.purple.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.blue.shade100.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.purple.shade400,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'اقتراحات التطوير:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.purple.shade900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        state.aiSuggestions!,
                        style: TextStyle(
                          height: 1.6,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(0.95, 0.95),
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(),
        ],
      ],
    );
  }
}
