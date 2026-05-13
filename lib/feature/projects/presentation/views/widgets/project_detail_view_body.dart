import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_style.dart';

class ProjectDetailsViewBody extends StatelessWidget {
  const ProjectDetailsViewBody({super.key, required this.projects});

  final ProjectEntity projects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          /// background glow
          Positioned(
            top: -120.h,
            right: -60.w,
            child: Container(
              width: 280.w,
              height: 280.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor.withValues(alpha: .08),
              ),
            ),
          ),

          Positioned(
            top: 140.h,
            left: -70.w,
            child: Container(
              width: 220.w,
              height: 220.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.secondaryColor.withValues(alpha: .08),
              ),
            ),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverHeader(context),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 26.h, 20.w, 140.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDescriptionCard(),
                      SizedBox(height: 24.h),

                      _buildSupervisorCard(),
                      SizedBox(height: 24.h),

                      _buildTeamCard(),
                      SizedBox(height: 24.h),

                      _buildAttachmentCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 24.h,
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  /// HEADER
  Widget _buildSliverHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColor.background,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .18),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Iconsax.arrow_right, color: Colors.white),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColor.primaryColor, AppColor.secondaryColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36.r),
              bottomRight: Radius.circular(36.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 55.h),

                  Container(
                    width: 76.w,
                    height: 76.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Icon(
                      Iconsax.teacher,
                      color: Colors.white,
                      size: 34.sp,
                    ),
                  ).animate().scale(duration: 450.ms),

                  SizedBox(height: 22.h),

                  Text(
                    projects.name,
                    style: AppTextStyle.bold(24, color: Colors.white),
                  ).animate().fade().slideY(begin: .2),

                  SizedBox(height: 14.h),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      _heroChip(
                        Iconsax.teacher,
                        projects.department ?? "غير محدد",
                      ),
                      _heroChip(
                        Iconsax.calendar,
                        projects.year.toString() ?? "",
                      ),
                      _heroChip(
                        Iconsax.profile_2user,
                        "${projects.students.length ?? 0} أعضاء",
                      ),
                    ],
                  ).animate().fade(delay: 200.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroChip(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .16),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white.withValues(alpha: .15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: Colors.white),
          SizedBox(width: 6.w),
          Text(title, style: AppTextStyle.medium(12, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(title, style: AppTextStyle.bold(17)),
        ],
      ),
    );
  }

  Widget _cardShell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }

  /// DESCRIPTION
  Widget _buildDescriptionCard() {
    return _cardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(AppStrings.aboutProject, Iconsax.document_text),
          Text(
            projects.description ?? "لا يوجد وصف للمشروع.",
            style: AppTextStyle.medium(
              14,
              color: AppColor.grey,
            ).copyWith(height: 1.8),
          ),
        ],
      ),
    ).animate().fade(delay: 100.ms).slideY(begin: .1);
  }

  /// SUPERVISOR
  Widget _buildSupervisorCard() {
    return _cardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(AppStrings.supervisor, Iconsax.teacher),

          Row(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(Iconsax.teacher, color: Colors.white, size: 28.sp),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projects.supervisor ?? "غير محدد",
                      style: AppTextStyle.bold(16),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "المشرف الأكاديمي",
                      style: AppTextStyle.medium(13, color: AppColor.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(delay: 200.ms).slideY(begin: .1);
  }

  /// TEAM
  Widget _buildTeamCard() {
    final students = projects.students ?? [];

    return _cardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(AppStrings.teamMembers, Icons.groups_outlined),

          if (students.isEmpty)
            Text(
              "لا يوجد أعضاء فريق",
              style: AppTextStyle.medium(13, color: AppColor.grey),
            )
          else
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: students.map((e) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: AppColor.primaryColor.withValues(
                          alpha: .1,
                        ),
                        child: Icon(
                          Iconsax.people,
                          size: 14.sp,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(e.toString(), style: AppTextStyle.medium(12)),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    ).animate().fade(delay: 300.ms).slideY(begin: .1);
  }

  /// FILE
  Widget _buildAttachmentCard() {
    final hasFile = projects.fileUrl != null;
    // && projects.fileUrl.isNotEmpty;

    return _cardShell(
      child: Row(
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Icon(
              Iconsax.document_download,
              color: Colors.red,
              size: 28.sp,
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ملف المشروع", style: AppTextStyle.bold(15)),
                SizedBox(height: 4.h),
                Text(
                  hasFile ? "ملف جاهز للعرض والتنزيل" : "لا يوجد ملف مرفق",
                  style: AppTextStyle.medium(12, color: AppColor.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade(delay: 400.ms).slideY(begin: .1);
  }

  /// BOTTOM ACTIONS
  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, color: Colors.white),
              label: Text(
                AppStrings.downloadFiles,
                style: AppTextStyle.medium(14, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size(0, 56.h),
                backgroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColor.secondaryColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColor.secondaryColor,
                size: 30.sp,
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1);
  }
}
