import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_style.dart';

class ProjectDetailsViewBody extends StatelessWidget {
  final ProjectEntity? projects;

  const ProjectDetailsViewBody({super.key, this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "تفاصيل المشروع",
          style: AppTextStyle.titleLarge18NormalStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      // 2. المحتوى القابل للتمرير
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ترويسة المشروع (الاسم + التخصص والسنة)
            _buildHeaderSection(),

            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // نبذة عن المشروع
                  _buildSectionTitle(
                    AppStrings.aboutProject,
                    Icons.info_outline,
                  ),
                  SizedBox(height: 12.h),
                  _buildDescriptionText(),

                  SizedBox(height: 30.h),

                  // المشرف
                  _buildSectionTitle(
                    AppStrings.supervisor,
                    Icons.person_pin_outlined,
                  ),
                  SizedBox(height: 12.h),
                  _buildSupervisorCard(),

                  SizedBox(height: 30.h),

                  // أعضاء الفريق
                  _buildSectionTitle(
                    AppStrings.teamMembers,
                    Icons.groups_outlined,
                  ),
                  SizedBox(height: 12.h),
                  _buildTeamList(),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. أزرار الإجراءات السفلية
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  // ==========================================
  // الهيدر العلوي (يحتوي على اسم المشروع والعلامات)
  // ==========================================
  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20.r,
        right: 20.r,
        bottom: 30.h,
        top: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projects?.name ?? "اسم المشروع غير متوفر",
            style: AppTextStyle.wellComeText.copyWith(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildInfoChip(
                Icons.calendar_today,
                projects?.year.toString() ?? "السنة غير محددة",
              ),
              SizedBox(width: 12.w),
              _buildInfoChip(
                Icons.school_outlined,
                projects?.department ?? "التخصص غير محدد",
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  // تصميم الـ Chips داخل الهيدر
  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.2,
        ), // شفافية خفيفة على اللون الأساسي
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16.r),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // العناوين الفرعية
  // ==========================================
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: 24.r),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyle.titleLarge18NormalStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  // ==========================================
  // نص الوصف (نظيف وبسيط للقراءة)
  // ==========================================
  Widget _buildDescriptionText() {
    return Text(
      projects?.description ?? "لا يوجد وصف متاح لهذا المشروع حتى الآن.",
      style: AppTextStyle.bodyMedium.copyWith(
        height: 1.7,
        fontSize: 14.sp,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    ).animate().fadeIn(delay: 300.ms);
  }

  // ==========================================
  // بطاقة الدكتور المشرف
  // ==========================================
  Widget _buildSupervisorCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: AppColor.primaryColor, size: 28.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projects?.supervisor ?? "غير محدد",
                  style: AppTextStyle.bodyLarge16NormalStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "المشرف الأكاديمي",
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  // ==========================================
  // قائمة الطلاب (مترتبة عمودياً كقائمة رسمية)
  // ==========================================
  Widget _buildTeamList() {
    // جلب الطلاب من الـ Entity
    final List<dynamic> studentsList = projects?.students ?? [];

    if (studentsList.isEmpty) {
      return const Text("لا يوجد طلاب مسجلين في هذا المشروع.");
    }

    return Column(
      children: studentsList.map((studentName) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: AppColor.secondaryColor,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    studentName.toString(),
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 500.ms);
  }

  // ==========================================
  // شريط الأزرار السفلي الثابت
  // ==========================================
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.r,
        right: 20.r,
        top: 16.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  // حدث التحميل
                },
                icon: const Icon(
                  Icons.download_for_offline_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  AppStrings.downloadFiles,
                  style: AppTextStyle.mainButtonText.copyWith(fontSize: 14.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: Size(0, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () {
                  // حدث العرض
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(0, 56.h),
                  side: const BorderSide(color: AppColor.secondaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Icon(
                  Icons.play_circle_outline,
                  color: AppColor.secondaryColor,
                  size: 28.r,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, end: 0, duration: 600.ms);
  }
}
