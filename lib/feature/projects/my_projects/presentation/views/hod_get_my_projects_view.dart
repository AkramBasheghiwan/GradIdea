// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_cubite.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/views/widgets/student_project_approved.dart';

class HodGetMyProjectsView extends StatelessWidget {
  const HodGetMyProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentProjectCubit(
        status: AppProjectsStatus.approved,
        repository: sl(),
      ),

      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: AppColor.background,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 20.w,
          title: Text('مشاريعك', style: AppTextStyle.bold(22)),
        ),

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// description
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 54.w,
                        height: 54.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withValues(alpha: .1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.rate_review_outlined,
                          color: AppColor.primaryColor,
                          size: 26.sp,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المشاريع التي رفعتها ',
                              style: AppTextStyle.bold(16),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "راجع المشاريع المقدمة واتخذ القرار المناسب بالموافقة أو الرفض.",
                              style: AppTextStyle.medium(
                                13,
                                color: AppColor.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 22.h),

                /// list
                const Expanded(child: StudentProjectApproved()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
