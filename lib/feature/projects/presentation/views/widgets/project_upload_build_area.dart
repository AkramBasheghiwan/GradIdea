// import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
// import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
// import 'package:graduation_management_idea_system/core/utils/images_assests.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
// import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';

// import '../../../../../core/utils/app_colors.dart';

// class ProjectUploadBuildArea extends StatelessWidget {
//   const ProjectUploadBuildArea({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(30.r),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(24.r),
//         border: Border.all(
//           color: AppColor.secondaryColor.withValues(alpha: 0.3),
//           style: BorderStyle.solid,
//         ), // Dash effect can be added via custom painter
//       ),
//       child: Column(
//         children: [
//           Image.asset(AppImageAssets.onboarding3, height: 80.h),
//           SizedBox(height: 16.h),
//           Text(
//             AppStrings.uploadFile,
//             style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             "الحد الأقصى 50 ميجابايت",
//             style: AppTextStyle.bodyMedium.copyWith(fontSize: 11.sp),
//           ),
//         ],
//       ),
//     ).animate().shake(delay: 1.seconds);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_state.dart';

// تأكد من استيراد الـ Cubit والـ State الخاصين بك
// import 'package:.../upload_project_cubit.dart';

class ProjectFileUploadArea extends StatelessWidget {
  const ProjectFileUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadProjectCubit, UploadProjectState>(
      builder: (context, state) {
        final bool hasFile = state.selectedFile != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ملف المشروع المرفق", style: AppTextStyle.bold(15)),
            SizedBox(height: 10.h),

            // تصميم منطقة الرفع
            InkWell(
              onTap: hasFile
                  ? null // إذا كان هناك ملف، لا تفعل شيئاً عند الضغط على المربع كامل
                  : () => context
                        .read<UploadProjectCubit>()
                        .pickProjectFile(), // فتح منتقي الملفات
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: hasFile
                      ? Colors.green.withValues(alpha: 0.05)
                      : Colors.grey.withValues(alpha: 0.05),
                  border: Border.all(
                    color: hasFile ? Colors.green : Colors.grey.shade400,
                    style: BorderStyle
                        .solid, // يمكنك استخدام حزمة dotted_border لجعله متقطعاً
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: hasFile
                    ? _buildFileSelected(
                        context,
                        state.fileName ?? "تم اختيار الملف",
                      )
                    : _buildUploadPlaceholder(),
              ),
            ),
          ],
        ).animate().shake(delay: 1.seconds);
      },
    );
  }

  // الواجهة في حالة "لم يتم اختيار ملف"
  Widget _buildUploadPlaceholder() {
    return Column(
      children: [
        Icon(
          Icons.cloud_upload_outlined,
          size: 40.sp,
          color: AppColor.primaryColor,
        ),
        SizedBox(height: 10.h),
        Text(
          "اضغط هنا لرفع ملف المشروع",
          style: TextStyle(fontSize: 14.sp, color: AppColor.primaryColor),
        ),
        SizedBox(height: 5.h),
        Text(
          "صيغ مدعومة: PDF, DOCX, ZIP (الحد الأقصى 10MB)",
          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
        ),
      ],
    );
  }

  // الواجهة في حالة "تم اختيار ملف بنجاح"
  Widget _buildFileSelected(BuildContext context, String fileName) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.insert_drive_file,
            color: Colors.green,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                "جاهز للرفع",
                style: TextStyle(fontSize: 11.sp, color: Colors.green),
              ),
            ],
          ),
        ),
        // زر الإلغاء (X)
        IconButton(
          icon: Icon(Icons.cancel, color: Colors.redAccent, size: 26.sp),
          onPressed: () {
            // استدعاء دالة مسح الملف من الـ Cubit
            context.read<UploadProjectCubit>().clearSelectedFile();
          },
        ),
      ],
    );
  }
}
